//
//  MarvelCharacter.swift
//  Marvelous
//
//  Created by Jon Allured on 1/21/15.
//  Copyright (c) 2015 Jon Allured. All rights reserved.
//

import Foundation

class MarvelCharacter: NSObject, NSCoding {
    let marvelId: String
    let name: String
    let imageURL: String?
    
    init(marvelId: String, name: String, imageURL: String?) {
        self.marvelId = marvelId
        self.name = name
        self.imageURL = imageURL
    }
    
    required init(coder aDecoder: NSCoder) {
        marvelId = aDecoder.decodeObjectForKey("marvelId") as String
        name = aDecoder.decodeObjectForKey("name") as String
        imageURL = aDecoder.decodeObjectForKey("imageURL") as String?
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(marvelId, forKey: "marvelId")
        aCoder.encodeObject(name, forKey: "name")
        if let url = imageURL {
            aCoder.encodeObject(url, forKey: "imageURL")
        }
    }
}