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
        
        /** Custom key mapping to get rid of the underscore. */
        enum CodingKeys: String, CodingKey {
            case name
            case url
            case promotedContent = "promoted_content"
            case query
            case tweetVolume = "tweet_volume"
        }
    }
}
