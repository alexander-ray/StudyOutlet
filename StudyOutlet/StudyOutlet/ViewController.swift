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
    
    @IBOutlet weak var CountDown: UILabel!
    @IBOutlet weak var ReviewButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let date = (defaults.object(forKey: "next_test_date") ?? Date()) as! Date
        let days = Helper.numDaysBeforeTest(testDate: date)
        CountDown.text = String(days) + " Days Until next Test"
    }
    
//    override func viewDidAppear(_ animated: Bool)
//    {
//        CountDown.text = String(dDate) + " Days Until next Test"
//    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
    @IBAction func Review(_ sender: UIButton) {
        performSegue(withIdentifier: "Review to Coming Soon", sender: self)
    }
    
    
}

