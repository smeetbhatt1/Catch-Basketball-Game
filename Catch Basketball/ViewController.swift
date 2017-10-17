//
//  ViewController.swift
//  Catch Basketball
//
//  Created by Smeet Bhatt on 17/10/17.
//  Copyright © 2017 Smeet Bhatt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bball1: UIImageView!
    @IBOutlet weak var bball2: UIImageView!
    @IBOutlet weak var bball3: UIImageView!
    @IBOutlet weak var bball4: UIImageView!
    @IBOutlet weak var bball5: UIImageView!
    @IBOutlet weak var bball6: UIImageView!
    @IBOutlet weak var bball7: UIImageView!
    @IBOutlet weak var bball8: UIImageView!
    @IBOutlet weak var bball9: UIImageView!
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var score = 0
    
    var counter = 0
    var timer = Timer()
    var hideTimer = Timer()
    var bballArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //check the highscores
        let highScore = UserDefaults.standard.object(forKey: "highScore")
        if highScore == nil {
            highScoreLabel.text = String(0)
        }
        if let newScore = highScore as? Int {
            highScoreLabel.text = String(newScore)
        }
        
        scoreLabel.text = String(score)
        
        let recogniser1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recogniser2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recogniser3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recogniser4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recogniser5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recogniser6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recogniser7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recogniser8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recogniser9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        
        bball1.addGestureRecognizer(recogniser1)
        bball2.addGestureRecognizer(recogniser2)
        bball3.addGestureRecognizer(recogniser3)
        bball4.addGestureRecognizer(recogniser4)
        bball5.addGestureRecognizer(recogniser5)
        bball6.addGestureRecognizer(recogniser6)
        bball7.addGestureRecognizer(recogniser7)
        bball8.addGestureRecognizer(recogniser8)
        bball9.addGestureRecognizer(recogniser9)
        
        bball1.isUserInteractionEnabled = true
        bball2.isUserInteractionEnabled = true
        bball3.isUserInteractionEnabled = true
        bball4.isUserInteractionEnabled = true
        bball5.isUserInteractionEnabled = true
        bball6.isUserInteractionEnabled = true
        bball7.isUserInteractionEnabled = true
        bball8.isUserInteractionEnabled = true
        bball9.isUserInteractionEnabled = true
        
        //creating timer
        counter = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        //hiding image timer
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideBball), userInfo: nil, repeats: true)
        
        //creating arrays
        bballArray.append(bball1)
        bballArray.append(bball2)
        bballArray.append(bball3)
        bballArray.append(bball4)
        bballArray.append(bball5)
        bballArray.append(bball6)
        bballArray.append(bball7)
        bballArray.append(bball8)
        bballArray.append(bball9)
        hideBball()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = String(score)
    }
    
    @objc func countDown() {
        timerLabel.text = String(counter)
        counter -= 1
        if counter == -1{
            timer.invalidate()
            hideTimer.invalidate()
            
            //checking highscore
            if self.score > Int(highScoreLabel.text!)! {
                UserDefaults.standard.set(self.score, forKey: "highScore")
                highScoreLabel.text = String(self.score)
            }
            //alert creation
            let alert = UIAlertController(title: "Time Over!!!", message: "Your Time is Up", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                for bball in self.bballArray {
                    bball.isUserInteractionEnabled = false
                } 
                })
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertActionStyle.default,
                                       handler: { (UIAlertAction) in
                                        self.score = 0
                                        self.scoreLabel.text = String(self.score)
                                        self.counter = 10
                                        self.timerLabel.text = String(self.counter)
                                        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                                        self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideBball), userInfo: nil, repeats: true)
            })
            alert.addAction(replay)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func hideBball() {
        for bball in bballArray {
            bball.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(bballArray.count-1)))
        bballArray[randomNumber].isHidden = false
    }
    
}

