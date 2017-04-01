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

    @IBOutlet weak var Input_year: UITextField!
    @IBOutlet weak var Input_month: UITextField!
    @IBOutlet weak var Input_day: UITextField!
    
//    var firstCellPhoneCallDateComponents = DateComponents()
//    firstCellPhoneCallDateComponents.year = 1973
//    firstCellPhoneCallDateComponents.month = 4
//    firstCellPhoneCallDateComponents.day = 3
//    
//    let firstCellPhoneCallDate = userCalendar.date(from: firstCellPhoneCallDateComponents)!
//    firstCellPhoneCallDate.timeIntervalSinceReferenceDate
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
