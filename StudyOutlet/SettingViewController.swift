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
    
    @IBOutlet weak var CountDown: UILabel!
    
    @IBAction func UpdateDate(_ sender: AnyObject)
    {
//        var dateComponents = DateComponents()
//        dateComponents.year = Int(Input_year.text!)
//        dateComponents.month = Int(Input_month.text!)
//        dateComponents.day = Int(Input_month.text!)
        
//        let examDate = calendar.date(from: dateComponents)
        
        let calendar = Calendar.current
        let currentDate = Date()
        let year  = Int(Input_year.text!)! - calendar.component(.year, from: currentDate)
        let month = Int(Input_month.text!)! - calendar.component(.month, from: currentDate)
        let day   = Int(Input_day.text!)! - calendar.component(.day, from: currentDate)
        dDate = year * 365 + month * 30 + day
        
        CountDown.text = String(dDate) + " Days Until next Test"
    }
    
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
