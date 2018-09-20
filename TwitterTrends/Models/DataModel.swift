//
//  DataModel.swift
//  TwitterTrends
//
//  Created by Daniel Henshaw on 20/9/18.
//  Copyright © 2018 Dan Henshaw. All rights reserved.
//

import Foundation

struct TrendingData : Codable {
    
    var trends: [TwitterData]
    
    struct TwitterData : Codable {
        var name : String
        var url : URL
        var promotedContent : String?
        var query : String?
        var tweetVolume : Int?
    }
}

struct ClosestData : Codable {
    let country : String
    let countryCode : String
    let name : String
    let parentid : Int
    let url : String
    let woeid : Int
}
