//
//  CharacterRequest.swift
//  Marvelous
//
//  Created by Jon Allured on 1/21/15.
//  Copyright (c) 2015 Jon Allured. All rights reserved.
//

import Foundation
import AlamoFire
import CryptoSwift

let url = "https://gateway.marvel.com/v1/public/characters"
let limit = "100"

class CharacterRequest: NSObject {
    let manager: Alamofire.Manager
    let offset: String
    
    required init(offset: String) {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 10
        
        self.manager = Alamofire.Manager(configuration: configuration)
        self.offset = offset
    }
    
    class func makeRequest(offset: String, success: (JSON) -> Void, failure: () -> Void) {
        self(offset: offset).makeRequest(success, failure: failure)
    }
    
    func makeRequest(success: (JSON) -> Void, failure: () -> Void) {
        let timestamp = currentTimestamp()
        
        let params = [
            "apikey" : publicKey,
            "ts" : timestamp,
            "hash" : md5Hash(timestamp),
            "offset" : offset,
            "limit" : limit
        ]
        
        manager.request(.GET, url, parameters: params).responseJSON {
            (request, response, data, error) in
            
            if let err = error {
                failure()
            } else {
                if let d: AnyObject = data {
                    let json = JSON(d)
                    success(json["data"]["results"])
                }
            }
        }
    }

    func currentTimestamp() -> String {
        return String(Int(NSDate().timeIntervalSince1970))
    }
    
    func md5Hash(timestamp: String) -> String {
        return (timestamp + privateKey + publicKey).md5()!.lowercaseString
    }
}