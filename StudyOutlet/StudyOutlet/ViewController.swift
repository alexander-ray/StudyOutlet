//
//  ViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/1/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

var dDate = 0

class ViewController: UIViewController
{
    // MARK: Outlets
    @IBOutlet weak var MissedProblemsButton: UIButton!
    @IBOutlet weak var CountDown: UILabel!
    @IBOutlet weak var ReviewButton: UIButton!
    
    // Load view
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Set current date, calculate number of days until date
        let date = (defaults.object(forKey: "next_test_date") ?? Date()) as! Date
        let days = Helper.numDaysBeforeTest(testDate: date)
        CountDown.text = String(days) + " Days Until next Test"
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: Actions
    // Segues to other pages
    @IBAction func Setting(_ sender: Any)
    {
        performSegue(withIdentifier: "ShowSetting", sender: self)
    }
    @IBAction func ToOPE(_ sender: Any)
    {
        performSegue(withIdentifier: "ToOPE", sender: self)
    }
    
    @IBAction func ToCEMenu(_ sender: Any)
    {
        performSegue(withIdentifier: "ShowCEMenu", sender: self)
    }
    @IBAction func MissedProblemsButton(_ sender: UIButton) {
        performSegue(withIdentifier: "MissedProblemButton", sender: self)
    }
    @IBAction func Review(_ sender: UIButton) {
        performSegue(withIdentifier: "Review to Coming Soon", sender: self)
    }
}

