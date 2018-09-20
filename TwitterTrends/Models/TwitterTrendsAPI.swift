//
//  TwitterTrendsAPI.swift
//  TwitterTrends
//
//  Created by Daniel Henshaw on 20/9/18.
//  Copyright © 2018 Dan Henshaw. All rights reserved.
//

import SafariServices

class TwitterTrendsAPI {
    
    let constants = Constants()
    
    func fetchTwitterTrends(bearerToken: String, woeid: String, completionHandler: @escaping (_ twitterTrends: [TrendingData.TwitterData]?, _ error: Error?) -> Void) {
        
        let url = URL(string: constants.baseURL + constants.trendsURLExtension)!

        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("Bearer " + bearerToken, forHTTPHeaderField: "Authorization")

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
        
            guard (error == nil) else {
                completionHandler(nil, error)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionHandler(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode([TrendingData].self, from: data)

                guard let response = responseData.first else {
                    completionHandler(nil, error)
                    return
                }
                completionHandler(response.trends, nil)
            } catch {
                completionHandler(nil, error)
            }

        }
        task.resume()
    }
}
