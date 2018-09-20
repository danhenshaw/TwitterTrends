//
//  TableView.swift
//  TwitterTrends
//
//  Created by Daniel Henshaw on 20/9/18.
//  Copyright © 2018 Dan Henshaw. All rights reserved.
//

import UIKit

class TableView : UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var twitterTrendCellId = "TwitterTrendCellId"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        
        tableView = UITableView()
        
        tableView.register(TwitterTrendViewCell.self, forCellReuseIdentifier: twitterTrendCellId)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .clear
        
    }
    
    func setupConstraints() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.fillSuperview()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: twitterTrendCellId, for: indexPath) as! TwitterTrendViewCell
        cell.label.text = "Default Table View Cell"
        return cell
    }
}
