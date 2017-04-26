//
//  ComingSoonViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/4/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

// View controller for coming soon page
class ComingSoonViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var CountDown: UILabel!
    
    // MARK: Actions
    @IBAction func BackOne(_ sender: Any)
    {
        performSegue(withIdentifier: "Back1", sender: self)
    }

    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup date
        let date = (defaults.object(forKey: "next_test_date") ?? Date()) as! Date
        let days = Helper.numDaysBeforeTest(testDate: date)
        CountDown.text = String(days) + " Days Until next Test"
    }
}
