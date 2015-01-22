//
//  Quiz.swift
//  Marvelous
//
//  Created by Jon Allured on 1/21/15.
//  Copyright (c) 2015 Jon Allured. All rights reserved.
//

import Foundation

class Quiz: NSObject {
    var questions = [Question]()
    var currentQuestionIndex = 0
    
    init(characters: [MarvelCharacter]) {
        for i in (0...9) {
            let step = i * 4
            var questionCharacters = [MarvelCharacter]()
            
            for j in (step...(step + 3)) {
                questionCharacters.append(characters[j])
            }
            
            questions.append(Question(characters: questionCharacters))
        }
    }
    
    func currentQuestion() -> Question? {
        if currentQuestionIndex < 10 {
            return questions[currentQuestionIndex]
        } else {
            return nil
        }
    }
    
    func scoreQuestion(answer: Bool) {
        currentQuestionIndex++
        
        // score the question??
    }
}