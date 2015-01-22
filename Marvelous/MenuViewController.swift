//
//  MenuViewController.swift
//  Marvelous
//
//  Created by Jon Allured on 1/21/15.
//  Copyright (c) 2015 Jon Allured. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    let characterStore = CharacterStore()
    
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var loadDataButton: UIButton!

    @IBAction func loadMoreData(sender: AnyObject) {
        loadDataButton.enabled = false
        characterStore.fetchNewPage()
    }
    
    @IBAction func unwindToMenu(sender: UIStoryboardSegue) {
        // noop
    }
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateCount", name: storeUpdated, object: characterStore)
        loadDataButton.setTitle("Loading...", forState: UIControlState.Disabled)
        loadDataButton.setTitle("Load Data", forState: UIControlState.Normal)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueIdentifier = segue.identifier {
            if segueIdentifier == "startQuiz" {
                let characters = characterStore.pickRandom(40)
                let quiz = Quiz(characters: characters)
                (segue.destinationViewController as QuizViewController).quiz = quiz
            }
        }
    }
    
    func updateCount() {
        characterCountLabel.text = "\(characterStore.characters.count) Characters"
        loadDataButton.enabled = true
    }
}