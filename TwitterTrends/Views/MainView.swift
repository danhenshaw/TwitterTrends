//
//  MainView.swift
//  TwitterTrends
//
//  Created by Daniel Henshaw on 20/9/18.
//  Copyright © 2018 Dan Henshaw. All rights reserved.
//

import UIKit

class MainView : UIView {
    
    var tableView = TableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.fillSuperview()
    }
    
    func configureView() {
        self.backgroundColor = .black
    }
  
}
