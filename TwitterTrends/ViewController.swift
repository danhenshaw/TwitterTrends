//
//  ViewController.swift
//  TwitterTrends
//
//  Created by Daniel Henshaw on 20/9/18.
//  Copyright © 2018 Dan Henshaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var authenticateUser = AuthenticateUser()
    var twitterTrendsAPI = TwitterTrendsAPI()
    
    var mainView: MainView { return self.view as! MainView }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        authenticateUser.getBearerToken { (bearerToken, error) in
            if let error = error {
                print("There was an error obtaining the bearer token: \(error)")
            }
            
            if let bearerToken = bearerToken {
                
                print("We have the bearer token: \(bearerToken)")
                
                self.twitterTrendsAPI.fetchTwitterTrends(bearerToken: bearerToken, woeid: "", completionHandler: { (twitterTrends, error) in
                    
                    if let error = error {
                        print("There was an error fetching tiwtter trends: \(error)")
                    }
                    
                    if let twitterTrends = twitterTrends {
                        print("We successfully downloaded the twitter trends: \(twitterTrends)")
                    }
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
    }


}

