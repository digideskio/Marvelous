//
//  Quiz.swift
//  Marvelous
//
//  Created by Jon Allured on 1/21/15.
//  Copyright (c) 2015 Jon Allured. All rights reserved.
//

import Foundation

class Quiz: NSObject {
    var characters: [MarvelCharacter]
    
    init(characters: [MarvelCharacter]) {
        self.characters = characters
    }
}