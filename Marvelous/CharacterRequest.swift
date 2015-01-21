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
    let offset: String
    
    required init(offset: String) {
        self.offset = offset
    }
    
    class func makeRequest(offset: String, fn: (JSON) -> Void) {
        self(offset: offset).makeRequest(fn)
    }
    
    func makeRequest(fn: (JSON) -> Void) {
        let timestamp = currentTimestamp()
        
        let params = [
            "apikey" : publicKey,
            "ts" : timestamp,
            "hash" : md5Hash(timestamp),
            "offset" : offset,
            "limit" : limit
        ]
        
        Alamofire.request(.GET, url, parameters: params).responseJSON {
            (request, response, data, error) in
            
            if let d: AnyObject = data {
                let json = JSON(d)
                fn(json["data"]["results"])
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