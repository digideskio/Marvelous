//
//  MarvelCharacter.swift
//  Marvelous
//
//  Created by Jon Allured on 1/21/15.
//  Copyright (c) 2015 Jon Allured. All rights reserved.
//

import Foundation

class MarvelCharacter: NSObject {
    let marvelId: String
    let name: String
    let imageURL: String?
    
    init(marvelId: String, name: String, imageURL: String?) {
        self.marvelId = marvelId
        self.name = name
        self.imageURL = imageURL
    }
}