//
//  Question.swift
//  Marvelous
//
//  Created by Jon Allured on 1/21/15.
//  Copyright (c) 2015 Jon Allured. All rights reserved.
//

import Foundation

class Question: NSObject {
    var characters: [MarvelCharacter]
    
    init(characters: [MarvelCharacter]) {
        self.characters = characters
    }
    
    convenience init(characters: [MarvelCharacter], shuffle: Bool) {
        self.init(characters: characters)
        
        if shuffle {
            shuffleCharacters()
        }
    }
    
    func shuffleCharacters() {
        var names = shuffle(characters.map { $0.name })
        
        var shuffledCharacters = [MarvelCharacter]()
        
        for index in 0...3 {
            let character = characters[index]
            
            let shuffledCharacter = MarvelCharacter(
                marvelId: character.marvelId,
                name: names[index],
                imageURL: character.imageURL
            )
            
            shuffledCharacters.append(shuffledCharacter)
        }
        
        characters = shuffledCharacters
    }
}

// stolen from ankurp/Dollar.swift
func shuffle<T>(array: [T]) -> [T] {
    var newArr = copy(array)
    for index in 0..<array.count {
        var randIndex = Int(arc4random_uniform(UInt32(index)))
        Swift.swap(&newArr[index], &newArr[randIndex])
    }
    return newArr
}

func copy<T>(array: [T]) -> [T] {
    var newArr : [T] = []
    for elem in array {
        newArr.append(elem)
    }
    return newArr
}