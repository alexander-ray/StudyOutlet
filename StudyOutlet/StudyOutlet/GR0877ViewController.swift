//
//  GR0877ViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/4/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

class GR0877ViewController: UIViewController {
    
    var minutes = 170
    var timer = Timer()
    var test = Test(testName: "GR0877")
    var questionIndex = 0
    
    // Outlets
    @IBOutlet weak var CountDown: UILabel!
    @IBOutlet weak var countMinute: UILabel!
    @IBOutlet weak var StartImageOutlet: UIImageView!
    @IBOutlet weak var StopImageOutlet: UIImageView!
    @IBOutlet weak var StartButtonOutlet: UIButton!
    @IBOutlet weak var StopButtonOutlet: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageOutlet: UIImageView!
    
    
    @IBOutlet weak var rightImageOutlet: UIImageView!
    @IBOutlet weak var nextOutlet: UIButton!
    @IBOutlet weak var leftImageOutlet: UIImageView!
    @IBOutlet weak var previousOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CountDown.text = String(dDate) + " Days Until next Test"
        
        rightImageOutlet.isHidden = true
        nextOutlet.isHidden = true
        leftImageOutlet.isHidden = true
        previousOutlet.isHidden = true
    }
    
    // --------------------
    // Code for timer:
    // --------------------
    @IBAction func Button_BackToOPEMenu(_ sender: Any)
    {
        performSegue(withIdentifier: "BackToOPEMenu", sender: self)
    }
    
    @IBAction func StartAction(_ sender: Any)
    {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GR0877ViewController.counter), userInfo: nil, repeats: true)
        
        test.getQuestions() { arr in
            self.test.questionArray = arr!
            if (self.test.questionArray.count > 0) {
                let question = self.test.questionArray[self.questionIndex].question
                self.imageView.image = question
            }
        }
        
//        self.questionIndex
        
        StartImageOutlet.isHidden = true
        StartButtonOutlet.isHidden = true
        imageOutlet.isHidden = false
        
        rightImageOutlet.isHidden = false
        nextOutlet.isHidden = false
    }
    
    @IBAction func StopAction(_ sender: Any)
    {
        timer.invalidate()
        minutes = 170
        countMinute.text = "170 min"
        StartImageOutlet.isHidden = false
        StartButtonOutlet.isHidden = false
        imageOutlet.isHidden = true
        
        rightImageOutlet.isHidden = true
        nextOutlet.isHidden = true
        leftImageOutlet.isHidden = true
        previousOutlet.isHidden = true
    }

    func counter()
    {
        minutes -= 1
        countMinute.text = String(minutes) + " min"
        
        if (minutes == 0)
        {
            timer.invalidate()
            StartImageOutlet.isHidden = false
            StartButtonOutlet.isHidden = false
            imageOutlet.isHidden = true
            
            rightImageOutlet.isHidden = true
            nextOutlet.isHidden = true
            leftImageOutlet.isHidden = true
            previousOutlet.isHidden = true
        }
    }
    // --------------------
    // Code for timer. end
    // --------------------
    
    
    
    // --------------------
    // Code for choice:
    // --------------------
    @IBOutlet weak var ChoiceOutlet: UILabel!
    
    @IBAction func A_Clicker(_ sender: Any)
    {
        ChoiceOutlet.text = "A"
    }
    
    @IBAction func B_Clicker(_ sender: Any)
    {
        ChoiceOutlet.text = "B"
    }
    
    @IBAction func C_Clicker(_ sender: Any)
    {
        ChoiceOutlet.text = "C"
    }
    
    @IBAction func D_Clicker(_ sender: Any)
    {
        ChoiceOutlet.text = "D"
    }
    
    @IBAction func E_Clicker(_ sender: Any)
    {
        ChoiceOutlet.text = "E"
    }
    
    @IBAction func nochoice_Clicker(_ sender: Any)
    {
        ChoiceOutlet.text = "--"
    }
    // --------------------
    // Code for choice. end
    // --------------------
    
    
    
    // -------------------------------
    // Code for switch Question:
    // -------------------------------
    @IBAction func next_Question(_ sender: Any)
    {
        if (questionIndex < 5)
        {
            questionIndex = questionIndex + 1
            
            test.getQuestions() { arr in
                self.test.questionArray = arr!
                if (self.test.questionArray.count > 0) {
                    let question = self.test.questionArray[self.questionIndex].question
                    self.imageView.image = question
                }
            }
            
            leftImageOutlet.isHidden = false
            previousOutlet.isHidden = false
            
            if (questionIndex == 4)
            {
                rightImageOutlet.isHidden = true
                nextOutlet.isHidden = true
            }
        }
    }
//    self.questionIndex
    @IBAction func previous_Question(_ sender: Any)
    {
        if (questionIndex > 0)
        {
            questionIndex = questionIndex - 1
            
            test.getQuestions() { arr in
                self.test.questionArray = arr!
                if (self.test.questionArray.count > 0) {
                    let question = self.test.questionArray[self.questionIndex].question
                    self.imageView.image = question
                }
            }
            
            rightImageOutlet.isHidden = false
            nextOutlet.isHidden = false
            
            if (questionIndex == 0)
            {
                leftImageOutlet.isHidden = true
                previousOutlet.isHidden = true
            }
        }
    }
    // -------------------------------
    // Code for switch Question. end
    // -------------------------------
}






















































