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
    
    override func viewDidLoad() {
        let characters = quiz.characters
        
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
        }
    }
}