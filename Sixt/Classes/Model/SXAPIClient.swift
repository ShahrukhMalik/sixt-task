//
//  SXAPIClient.swift
//  Sixt
//
//  Created by Shahrukh on 23/12/2016.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

typealias CompletionBlock = (_ success: Bool, _ result: Any?, _ error: NSError?) -> ()

class SXAPIClient: NSObject {
    
    
    // MARK: Shared Instance
    
    static let sharedClient : SXAPIClient = {
        let instance = SXAPIClient()
        return instance
    }()
    
    
    // MARK: - Public methods
    
    func sendCarsInfoRequestWithCompletion(completion: @escaping CompletionBlock) {
        let urlString: String = "http://www.codetalk.de/cars.json"
        
        sendRequestWithURLString(urlString: urlString, isPost: false, completion: completion)
    }
    
    
    // MARK: - Private methods
    
    private func sendRequestWithURLString(urlString: String,
                                          isPost: Bool,
                                          completion: @escaping CompletionBlock)
    {
        let encURLString: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print("REQUEST URL : \(encURLString)")
        
        var reqMethod = HTTPMethod.get
        
        if isPost {
            reqMethod = HTTPMethod.post
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        request(encURLString, method: reqMethod, parameters: nil, headers: nil)
            .responseString { response in
//                print("Success: \(response.result.isSuccess)")
//                print("Response String: \(response.result.value)")
//                print("Response Error: \(response.result.error)")
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                if response.result.error == nil {
                    
                    let respStr: String? = response.result.value
                    let data = respStr!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
                    
                    var jsonObject: Any?
                    
                    do {
                        jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                        
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                    print("Response : ", jsonObject!)
                    completion(true, jsonObject, nil)
                    
                } else {
                    print("Error : ", (response.result.error)!)
                    completion(false, nil, response.result.error as NSError?)
                }
        }
    }
}
