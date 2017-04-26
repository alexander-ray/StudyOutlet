//
//  SettingViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/1/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

// View controller for settings view
class SettingViewController: UIViewController
{
    // MARK: Outlets
    @IBOutlet weak var CountDown: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: Actions
    @IBAction func UpdateDate(_ sender: AnyObject)
    {
        let currentDate = Date()
        if (currentDate.compare(datePicker.date) == .orderedDescending) {
            // Set up "invalid date" alert
            let alertController = UIAlertController(title: "Invalid Date", message: "Date and time must be in the future.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
                (result : UIAlertAction) -> Void in
                print("You pressed OK")
            }
            alertController.addAction(okAction)
            // Present alert
            self.present(alertController, animated: true, completion: nil)
            
            // Reset countdown
            CountDown.text = String(0) + " Days Until next Test"
        }
        else {
            defaults.set(datePicker.date, forKey: "next_test_date")
            CountDown.text = String(Helper.numDaysBeforeTest(testDate: datePicker.date)) + " Days Until next Test"
            
            // Return back to main menu
            performSegue(withIdentifier: "BackToMenu", sender: self)
        }
        
    }
    @IBAction func logoutAction(_ sender: UIButton) {
        // Remove access key
        defaults.set("-1", forKey: "api_access_key")
        performSegue(withIdentifier: "BackToLogin", sender: self)
    }
    @IBAction func BackToMenu(_ sender: Any)
    {
        performSegue(withIdentifier: "BackToMenu", sender: self)
    }

    // Loading view
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set current date, calculate number of days until date
        let date = (defaults.object(forKey: "next_test_date") ?? Date()) as! Date
        let days = Helper.numDaysBeforeTest(testDate: date)
        CountDown.text = String(days) + " Days Until next Test"
    }
}

extension Date {
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
}
