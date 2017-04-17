//
//  GR0877ViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/4/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

class GR0877ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var minutes = defaults.integer(forKey: "test_length")

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
    @IBAction func StartAction(_ sender: Any)
    {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GR0877ViewController.counter), userInfo: nil, repeats: true)
        
        StartImageOutlet.isHidden = true
        StartButtonOutlet.isHidden = true
        StopImageOutlet.isHidden = false
        StopButtonOutlet.isHidden = false

        imageOutlet.isHidden = false
        
        answerPicker.isHidden = false
        submitButton.isHidden = false
    }
    
    @IBAction func StopAction(_ sender: Any)
    {
        timer.invalidate()
        minutes = 170

        let alertController = UIAlertController(title: "", message: "Are you sure you want to stop this test? Your progress will not be saved.", preferredStyle: UIAlertControllerStyle.alert)
        let stopAction = UIAlertAction(title: "Stop", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            self.performSegue(withIdentifier: "BackToOPEMenu", sender: self)
        }
        let backAction = UIAlertAction(title: "Back to Test", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
        }
        alertController.addAction(backAction)
        alertController.addAction(stopAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if (currentAnswer == test.questionArray[questionIndex].answer) {
            if (questionIndex == numQuestions - 1) {
                presentFinalAlert()
            }
            else {
                presentCorrectAlert()
            }
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
        // If there was no data in user defaults
        if (minutes == 0) {
            minutes = 170
        }
        countMinute.text = String(minutes) + " min"
        
        let date = (defaults.object(forKey: "next_test_date") ?? Date()) as! Date
        let days = Helper.numDaysBeforeTest(testDate: date)
        CountDown.text = String(days) + " Days Until next Test"
        
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
        StopImageOutlet.isHidden = true
        StopButtonOutlet.isHidden = true
        
        
        submitButton.isHidden = true
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
    
    
    // Alerts
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
    
    func presentFinalAlert() {
        // Set up "invalid date" alert
        let alertController = UIAlertController(title: "Correct!", message: "You've completed this test!.", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Finish", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            self.performSegue(withIdentifier: "BackToOPEMenu", sender: self)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}






















































