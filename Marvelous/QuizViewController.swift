//
//  QuizViewController.swift
//  Marvelous
//
//  Created by Jon Allured on 1/21/15.
//  Copyright (c) 2015 Jon Allured. All rights reserved.
//

import UIKit
import AlamoFire

class QuizViewController: UIViewController {
    var quiz: Quiz!
    
    @IBOutlet weak var topLeftImageView: UIImageView!
    @IBOutlet weak var topLeftNameLabel: UILabel!
    
    @IBOutlet weak var topRightImageView: UIImageView!
    @IBOutlet weak var topRightNameLabel: UILabel!
    
    @IBOutlet weak var bottomLeftImageView: UIImageView!
    @IBOutlet weak var bottomLeftNameLabel: UILabel!
    
    @IBOutlet weak var bottomRightImageView: UIImageView!
    @IBOutlet weak var bottomRightNameLabel: UILabel!
    
    @IBAction func correctButton(sender: AnyObject) {
        scoreAnswer(true)
    }
    
    @IBAction func wrongButton(sender: AnyObject) {
        scoreAnswer(false)
    }
    
    override func viewDidLoad() {
        if let currentQuestion = quiz.currentQuestion() {
            populateImages(currentQuestion.characters)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func populateImages(characters: [MarvelCharacter]) {
        UIView.animateWithDuration(0.25) {
            self.topLeftImageView.alpha = 0
            self.topRightImageView.alpha = 0
            self.bottomLeftImageView.alpha = 0
            self.bottomRightImageView.alpha = 0
        }
        
        fetchImage(characters[0].imageURL!, imageView: topLeftImageView)
        topLeftNameLabel.text = characters[0].name
        
        fetchImage(characters[1].imageURL!, imageView: topRightImageView)
        topRightNameLabel.text = characters[1].name
        
        fetchImage(characters[2].imageURL!, imageView: bottomLeftImageView)
        bottomLeftNameLabel.text = characters[2].name
        
        fetchImage(characters[3].imageURL!, imageView: bottomRightImageView)
        bottomRightNameLabel.text = characters[3].name
    }
    
    func fetchImage(url: String, imageView: UIImageView) {
        Alamofire.request(.GET, url).response() {
            (_, _, data, _) in
            let image = UIImage(data: data! as NSData)
            imageView.image = image
            
            UIView.animateWithDuration(0.25) {
                imageView.alpha = 1
            }
        }
    }
    
    func scoreAnswer(answer: Bool) {
        quiz.scoreQuestion(answer)
        if let currentQuestion = quiz.currentQuestion() {
            populateImages(currentQuestion.characters)
        } else {
            let alert = UIAlertController(title: "Some(Congrats)", message: "\(quiz.correctAnswers) correct answers", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "LOL!", style: .Default) { (action) in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            alert.addAction(action)
            
            self.presentViewController(alert, animated: true, nil)
        }
    }
}