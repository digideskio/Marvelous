//
//  CharacterStore.swift
//  Marvelous
//
//  Created by Jon Allured on 1/21/15.
//  Copyright (c) 2015 Jon Allured. All rights reserved.
//

import Foundation

let storeUpdated = "storeUpdated"

class CharacterStore: NSObject {
    var characters = [MarvelCharacter]()
    var currentOffset = 0
    
    func validCharacters() -> [MarvelCharacter] {
        return characters.filter { $0.imageURL != nil }
    }
    
    func pickRandom(count: Int) -> [MarvelCharacter] {
        let valid = validCharacters()
        
        var indicies = [Int]()
        
        while (indicies.count < count) {
            let index = Int(arc4random_uniform(UInt32(valid.count)))
            if !contains(indicies, index) {
                indicies.append(index)
            }
        }
        
        let pickedCharacters = indicies.map { valid[$0] }
        
        return pickedCharacters
    }
    
    func fetchNewPage() {
        CharacterRequest.makeRequest(String(currentOffset), parseResults)
    }
    
    func parseResults(results: JSON) {
        currentOffset += 100
        
        for (_, result) in results {
            let id = result["id"].stringValue
            let name = result["name"].stringValue
            
            let thumbnail = result["thumbnail"]
            var imageURL: String?
            
            if thumbnail != nil {
                let path = thumbnail["path"].stringValue
                let ext = thumbnail["extension"].stringValue
                imageURL = "\(path).\(ext)"
            }
            
            let character = MarvelCharacter(marvelId: id, name: name, imageURL: imageURL)
            characters.append(character)
        }
        
        let notification = NSNotification(name: storeUpdated, object: self)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
}