//
//  TwitterTrendsViewCell.swift
//  TwitterTrends
//
//  Created by Daniel Henshaw on 20/9/18.
//  Copyright © 2018 Dan Henshaw. All rights reserved.
//

import UIKit

class TwitterTrendViewCell : UITableViewCell {
    
    var label : UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        
        label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "Helvetica Neue", size: 28)
        
        self.backgroundColor = .clear
    }
    
    func setupConstraints() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.fillSuperview()
    }
    
}
