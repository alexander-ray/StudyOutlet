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
    
    // Outlets
    @IBOutlet weak var CountDown: UILabel!
    @IBOutlet weak var countMinute: UILabel!
    @IBOutlet weak var StartImageOutlet: UIImageView!
    @IBOutlet weak var StopImageOutlet: UIImageView!
    @IBOutlet weak var StartButtonOutlet: UIButton!
    @IBOutlet weak var StopButtonOutlet: UIButton!
    
    @IBAction func Button_BackToOPEMenu(_ sender: Any)
    {
        performSegue(withIdentifier: "BackToOPEMenu", sender: self)
    }
    @IBAction func StartAction(_ sender: Any)
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GR0877ViewController.counter), userInfo: nil, repeats: true)
        
        StartImageOutlet.isHidden = true
        StartButtonOutlet.isHidden = true
    }
    @IBAction func StopAction(_ sender: Any)
    {
        timer.invalidate()
        minutes = 170
        countMinute.text = "170 min"
        StartImageOutlet.isHidden = false
        StartButtonOutlet.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CountDown.text = String(dDate) + " Days Until next Test"
        // Populate test's question array
        test.getQuestions() { arr in
            self.test.questionArray = arr!
        }
        if (test.questionArray.count > 0) {
            let question = test.questionArray[0].question
            let imageView = UIImageView(image: question)
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
            view.addSubview(imageView)
        }
        
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
        }
    }
}
