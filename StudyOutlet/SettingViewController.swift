//
//  SettingViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/1/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController
{
    @IBOutlet weak var CountDown: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
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
            let calendar = Calendar.current
            let year  = datePicker.calendar.component(.year, from: datePicker.date) - calendar.component(.year, from: currentDate)
            let month = datePicker.calendar.component(.month, from: datePicker.date) - calendar.component(.month, from: currentDate)
            let day   = datePicker.calendar.component(.day, from: datePicker.date) - calendar.component(.day, from: currentDate)
            dDate = year * 365 + month * 30 + day
            print(dDate)
            CountDown.text = String(dDate) + " Days Until next Test"
            
            // Return back to main menu
            performSegue(withIdentifier: "BackToMenu", sender: self)
        }
        
    }
    @IBAction func logoutAction(_ sender: UIButton) {
        // Remove access key
        defaults.set("-1", forKey: "api_access_key")
        performSegue(withIdentifier: "BackToLogin", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CountDown.text = String(dDate) + " Days Until next Test"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackToMenu(_ sender: Any)
    {
        performSegue(withIdentifier: "BackToMenu", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Date {
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
}
