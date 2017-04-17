//
//  GR0877ViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/4/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

class GR0877ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var minutes = 170
    var timer = Timer()
    var test = Test(testName: "GR0877")
    var questionIndex = 0
    var numQuestions = 0
    var currentAnswer = ""
    
    let answers = ["A", "B", "C", "D", "E"]
    
    // MARK: Outlets
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
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var answerPicker: UIPickerView!
    
    // MARK: Actions
    @IBAction func Button_BackToOPEMenu(_ sender: Any)
    {
        performSegue(withIdentifier: "BackToOPEMenu", sender: self)
    }
    
    @IBAction func StartAction(_ sender: Any)
    {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GR0877ViewController.counter), userInfo: nil, repeats: true)
        
        StartImageOutlet.isHidden = true
        StartButtonOutlet.isHidden = true
        imageOutlet.isHidden = false
        
        answerPicker.isHidden = false
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
    @IBAction func submit(_ sender: UIButton) {
        if (currentAnswer == test.questionArray[questionIndex].answer) {
            presentCorrectAlert()
        }
        else {
            presentIncorrectAlert()
        }
    }

    // MARK: Picker
    // returns the number of 'columns' to display.
    func numberOfComponents(in: UIPickerView) -> Int{
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return answers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return answers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        currentAnswer = answers[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        CountDown.text = String(dDate) + " Days Until next Test"
        
        test.getQuestions() { arr in
            self.test.questionArray = arr!
            self.numQuestions = self.test.questionArray.count
            if (self.numQuestions > 0) {
                let question = self.test.questionArray[0].question
                self.imageView.image = question
            }
        }
        
        imageOutlet.isHidden = true
        rightImageOutlet.isHidden = true
        nextOutlet.isHidden = true
        leftImageOutlet.isHidden = true
        previousOutlet.isHidden = true
        
        answerPicker.isHidden = true
        answerPicker.delegate = self
        answerPicker.dataSource = self        
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
    
    func nextQuestion() {
        if (questionIndex < numQuestions)
        {
            questionIndex = questionIndex + 1
            let question = self.test.questionArray[self.questionIndex].question
            self.imageView.image = question
        }

    }
    func previousQuestion() {
        if (questionIndex > 0)
        {
            questionIndex = questionIndex - 1
            let question = self.test.questionArray[self.questionIndex].question
            self.imageView.image = question
        }
    }
    
    func presentCorrectAlert() {
        // Set up "invalid date" alert
        let alertController = UIAlertController(title: "Correct!", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Next Question", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            self.nextQuestion()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentIncorrectAlert() {
        // Set up "invalid date" alert
        let alertController = UIAlertController(title: "Incorrect!", message: "Please try again.", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}






















































