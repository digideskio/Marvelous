//
//  CharacterStore.swift
//  Marvelous
//
//  Created by Jon Allured on 1/21/15.
//  Copyright (c) 2015 Jon Allured. All rights reserved.
//

import Foundation

let storeUpdated = "storeUpdated"
let storeUpdateFailure = "storeUpdateFailure"

class CharacterStore: NSObject, NSCoding {
    var characters = [MarvelCharacter]()
    var currentOffset = 0
    
    let charactersArchivePath: String = {
        let documentsDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = documentsDirectories.first as String
        
        return documentDirectory.stringByAppendingPathComponent("characters.archive")
    }()
    
    let storeArchivePath: String = {
        let documentsDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = documentsDirectories.first as String
        
        return documentDirectory.stringByAppendingPathComponent("store.archive")
    }()
    
    override init() {
        super.init()
        
        if let archivedCharacters = NSKeyedUnarchiver.unarchiveObjectWithFile(charactersArchivePath) as? [MarvelCharacter] {
            characters = archivedCharacters
        }
        
        if let archivedStore = NSKeyedUnarchiver.unarchiveObjectWithFile(storeArchivePath) as? CharacterStore {
            currentOffset = archivedStore.currentOffset
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        currentOffset = Int(aDecoder.decodeIntForKey("currentOffset"))
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInt(Int32(currentOffset), forKey: "currentOffset")
    }
    
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
        CharacterRequest.makeRequest(String(currentOffset), parseResults, updateFailure)
    }
    
    func updateFailure() {
        let notification = NSNotification(name: storeUpdateFailure, object: self)
        NSNotificationCenter.defaultCenter().postNotification(notification)
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
        
        NSKeyedArchiver.archiveRootObject(characters, toFile: charactersArchivePath)
        NSKeyedArchiver.archiveRootObject(self, toFile: storeArchivePath)
        
        let notification = NSNotification(name: storeUpdated, object: self)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
}