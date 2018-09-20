//
//  Authenticate.swift
//  TwitterTrends
//
//  Created by Daniel Henshaw on 20/9/18.
//  Copyright © 2018 Dan Henshaw. All rights reserved.
//

import SafariServices

class AuthenticateUser {
    
    let constants = Constants()
    
    func getBearerToken(completionHandler: @escaping (_ bearerToken: String?, _ error: Error?) -> Void) {
        
        let url = URL(string: constants.baseURL + constants.tokenURLExtension)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("Basic " + getBase64EncodeString(), forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
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
            
            var responseObjects : Dictionary<String, String>!

            do {
                responseObjects = try JSONSerialization.jsonObject(with: data) as? Dictionary<String, String>
                guard let bearerToken = responseObjects?["access_token"] else {
                    completionHandler(nil, error)
                    return
                }
                completionHandler(bearerToken, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
    
    private func getBase64EncodeString() -> String {
        let consumerKeyRFC1738 = constants.consumerKey.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let consumerSecretRFC1738 = constants.consumerSecret.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let concatenateKeyAndSecret = consumerKeyRFC1738! + ":" + consumerSecretRFC1738!
        let secretAndKeyData = Data(concatenateKeyAndSecret.utf8)
        let base64EncodeKeyAndSecret = secretAndKeyData.base64EncodedString()
        return base64EncodeKeyAndSecret
    }
}
