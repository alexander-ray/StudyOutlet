//
//  CustomizeMenuViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/9/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

var C_time = 20
var numQuestions = 6

class CustomizeMenuViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var CountDown: UILabel!
    @IBOutlet weak var C_time_label: UILabel!
    @IBOutlet weak var C_time_sliderOutlet: UISlider!
    @IBOutlet weak var numberOfQuestionsLabel: UILabel!
    @IBOutlet weak var questionsSliderOutlet: UISlider!
    
    // MARK: Actions
    @IBAction func BackToMainMenu(_ sender: Any)
    {
        // Save information
        defaults.set(C_time, forKey: "test_length")
        defaults.set(numQuestions, forKey: "num_questions")
        performSegue(withIdentifier: "BackToMainCE", sender: self)
    }
    // Slider handlers
    @IBAction func C_time_slider(_ sender: UISlider)
    {
        C_time = Int(sender.value)
        C_time_label.text = String(C_time) + " minutes"
    }
    @IBAction func questionsSlider(_ sender: UISlider) {
        numQuestions = Int(sender.value)
        numberOfQuestionsLabel.text = String(numQuestions) + " questions"
    }

    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Date setup
        let date = (defaults.object(forKey: "next_test_date") ?? Date()) as! Date
        let days = Helper.numDaysBeforeTest(testDate: date)
        CountDown.text = String(days) + " Days Until next Test"
    }
}



















