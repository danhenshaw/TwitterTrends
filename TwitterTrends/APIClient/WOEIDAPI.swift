//
//  WOEIDAPI.swift
//  TwitterTrends
//
//  Created by Daniel Henshaw on 20/9/18.
//  Copyright © 2018 Dan Henshaw. All rights reserved.
//

import SafariServices

class WOEIDAPI {
    
    let constants = Constants()
    
    func fetchWoeid(bearerToken: String, latitude: String, longitude: String, completionHandler: @escaping (_ closestData: ClosestData?, _ woeid: Int?, _ error: Error?) -> Void) {
        
        let url = URL(string: constants.baseURL + constants.trendsClosestURLExtension + String(format: constants.coordinatesURLExtension, latitude, longitude))!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + bearerToken, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            guard (error == nil) else {
                completionHandler(nil, nil, error)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, nil, error)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionHandler(nil, nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode([ClosestData].self, from: data)
                
                guard let response = responseData.first else {
                    completionHandler(nil, nil, error)
                    return
                }
                completionHandler(response, response.woeid, nil)
            } catch {
                completionHandler(nil, nil, error)
            }
            
        }
        task.resume()
    }
}
