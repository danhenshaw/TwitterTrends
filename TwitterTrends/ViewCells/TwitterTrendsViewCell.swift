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
    var url : UILabel!
    var stackView : UIStackView!
    
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
        label.textAlignment = .left
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "Helvetica Neue", size: 18)
        
        url = UILabel()
        url.textAlignment = .left
        url.textColor = .gray
        url.backgroundColor = .clear
        url.font = UIFont(name: "Helvetica Neue", size: 12)
        
        stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 2

        self.backgroundColor = .clear
    }
    
    func setupConstraints() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(url)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.anchor(top: self.topAnchor,
                         leading: self.leadingAnchor,
                         bottom: self.bottomAnchor,
                         trailing: self.trailingAnchor,
                         padding: .init(top: 4, left: 8, bottom: -4, right: -4),
                         size: .init(width: 0, height: 0))
    }
    
}
