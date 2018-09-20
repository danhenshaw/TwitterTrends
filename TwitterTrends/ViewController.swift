//
//  ViewController.swift
//  TwitterTrends
//
//  Created by Daniel Henshaw on 20/9/18.
//  Copyright © 2018 Dan Henshaw. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    var tableView : UITableView!
    var headerLabel : UILabel!
    var subHeaderLabel : UILabel!
    
    var authenticateUser = AuthenticateUser()
    var twitterTrendsAPI = TwitterTrendsAPI()
    var woeidAPI = WOEIDAPI()
    let locationManager = LocationManager()
    
    var retrievedWoeidData : ClosestData? = nil
    
    var twittersTrendingTopics : [TrendingData.TwitterData] = [] { didSet {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        }}
    
    var latitude = ""
    var longitude = ""
    
    var twitterTrendCellId = "TwitterTrendCellId"
    
    var coordinatesRetrieved = false { didSet {
        if latitude != "" && longitude != "" {
            print("Did set coordinates: ", latitude, longitude)
            startAuthorisationAndFetchingProcess(latitude: latitude, longitude: longitude)
        }
        }}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureHeaderView()
        configureTableView()
        view.backgroundColor = .black

        locationManager.delegate = self
        locationManager.getLocation()
    }
    
    func configureHeaderView() {
        headerLabel = UILabel()
        headerLabel.backgroundColor = .clear
        headerLabel.textColor = .white
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont(name: "Helvetica Neue", size: 24)
        headerLabel.text = "Trending Twitter Topics"
        
        subHeaderLabel = UILabel()
        subHeaderLabel.backgroundColor = .clear
        subHeaderLabel.textColor = .gray
        subHeaderLabel.textAlignment = .center
        subHeaderLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        subHeaderLabel.text = "...currently fetching your location"
        
        view.addSubview(headerLabel)
        view.addSubview(subHeaderLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        subHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           leading: view.leadingAnchor,
                           bottom: nil,
                           trailing: view.trailingAnchor,
                           padding: .init(top: 8, left: 8, bottom: -4, right: -8),
                           size: .init(width: 0, height: 44))
        
        subHeaderLabel.anchor(top: headerLabel.bottomAnchor,
                              leading: view.leadingAnchor,
                              bottom: nil,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 8, left: 8, bottom: -4, right: -8),
                              size: .init(width: 0, height: 30))
    }
    
    func updateSubHeaderLabel(text: String) {
        DispatchQueue.main.async {
            self.subHeaderLabel.text = text
        }
    }
    
    //    MARK : Start retrieving Twitter trending topics by location. Begins once the users location has been retrieved
    //    - Step 1: fetch bearer token
    //    - Step 2: fecth woeid data
    //    - Step 3: fetch twitter trending topics

    func startAuthorisationAndFetchingProcess(latitude: String, longitude: String) {
        
        updateSubHeaderLabel(text: "...fetching bearer token")
        
        authenticateUser.getBearerToken { (bearerToken, error) in
            if let error = error {
                print("There was an error obtaining the bearer token: \(error)")
                self.updateSubHeaderLabel(text: "There was an error. Please try again later")
            }
            
            if let bearerToken = bearerToken {
                
                self.updateSubHeaderLabel(text: "...fetching 'Where On Earth ID'")
                
                self.woeidAPI.fetchWoeid(bearerToken: bearerToken, latitude: latitude, longitude: longitude, completionHandler: { (closestData, woeid, error) in
                    if let error = error {
                        print("There was an error obtaing the woeid: \(error)")
                        self.updateSubHeaderLabel(text: "There was an error. Please try again later")
                    }
                    
                    if let closestData = closestData {
                        self.retrievedWoeidData = closestData
                        self.updateSubHeaderLabel(text: "...fetching Twitter's trending topics")
                    }
                    
                    if let woeid = woeid {
                        self.twitterTrendsAPI.fetchTwitterTrends(bearerToken: bearerToken, woeid: String(woeid), completionHandler: { (twitterTrends, error) in
                            
                            if let error = error {
                                print("There was an error fetching tiwtter trends: \(error)")
                                self.updateSubHeaderLabel(text: "There was an error. Please try again later")
                            }
                            
                            if let twitterTrends = twitterTrends {
                                self.twittersTrendingTopics = twitterTrends
                                
                                let cityName = self.retrievedWoeidData?.name
                                let country = self.retrievedWoeidData?.country
                                
                                if let cityName = cityName {
                                    if let country = country {
                                        self.updateSubHeaderLabel(text: "Showing current trends in \(cityName), \(country)")
                                    }
                                } else {
                                    self.updateSubHeaderLabel(text: "Showing current trends in your location")
                                }
                            }
                        })
                    }
                })
            }
        }
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TwitterTrendViewCell.self, forCellReuseIdentifier: twitterTrendCellId)
        tableView.backgroundColor = .clear
        tableView.anchor(top: subHeaderLabel.bottomAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 8, left: 8, bottom: -8, right: -8),
                         size: .init(width: 0, height: 0))
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twittersTrendingTopics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: twitterTrendCellId, for: indexPath) as! TwitterTrendViewCell
        let trendingTopic = twittersTrendingTopics[indexPath.row]
        cell.label.text = trendingTopic.name
        cell.url.text = "\(trendingTopic.url)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trendingTopic = twittersTrendingTopics[indexPath.row]
        let safariViewController = SFSafariViewController(url: trendingTopic.url)
        present(safariViewController, animated: true)
    }
}

extension ViewController : ReturnLocationDelegate {
    func updateLocationData(currentLatitude: Double, currentLongitude: Double) {
        latitude = String(currentLatitude)
        longitude = String(currentLongitude)
        coordinatesRetrieved = true
    }
    
}
