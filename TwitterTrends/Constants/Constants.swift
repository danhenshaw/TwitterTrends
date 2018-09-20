//
//  Constants.swift
//  TwitterTrends
//
//  Created by Daniel Henshaw on 20/9/18.
//  Copyright © 2018 Dan Henshaw. All rights reserved.
//

struct Constants {
    
    let consumerKey = ""
    let consumerSecret = ""
    
    let baseURL = "https://api.twitter.com/"
    let tokenURLExtension = "oauth2/token"

    
    let globalWoeidURExtension = "id=1"
    let woeidURLExtension = "id=%@"
    let trendsClosestURLExtension = "1.1/trends/closest.json?"
    let trendsPlacesURLExtension = "1.1/trends/place.json?"
    let coordinatesURLExtension = "lat=%@&long=%@"
}
