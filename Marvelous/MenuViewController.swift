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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fetchFailed", name: storeUpdateFailure, object: characterStore)
        loadDataButton.setTitle("Fetching...", forState: UIControlState.Disabled)
        loadDataButton.setTitle("Fetch Characters", forState: UIControlState.Normal)
        
        updateCount()
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
    
    func fetchFailed() {
        let alert = UIAlertController(title: "Fetch Failed!", message: "Marvel took too long to respond", preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "grumble", style: .Default) { (action) in
            self.updateCount()
        }
        
        alert.addAction(action)
        self.presentViewController(alert, animated: true, nil)
    }
}