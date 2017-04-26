//
//  OPEViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/1/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

// Test choice view controller
class OPEViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var CountDown: UILabel!
    
    // MARK: Actions
    @IBAction func BackToMenuOPE(_ sender: Any)
    {
        performSegue(withIdentifier: "BackToMenuOPE", sender: self)
    }
    
    @IBAction func GoToExam0877(_ sender: Any)
    {
        performSegue(withIdentifier: "ToGR0877", sender: self)
    }
    
    @IBAction func GoToExam0177(_ sender: Any)
    {
        performSegue(withIdentifier: "ToComingSoon", sender: self)
    }

    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up num days remaining counter
        let date = (defaults.object(forKey: "next_test_date") ?? Date()) as! Date
        let days = Helper.numDaysBeforeTest(testDate: date)
        CountDown.text = String(days) + " Days Until next Test"
    }
}
