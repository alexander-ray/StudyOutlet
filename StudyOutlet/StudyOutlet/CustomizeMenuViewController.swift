//
//  CustomizeMenuViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/9/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

var C_time = 20

class CustomizeMenuViewController: UIViewController {
    
    @IBOutlet weak var CountDown: UILabel!
    
    @IBAction func BackToMainMenu(_ sender: Any)
    {
        performSegue(withIdentifier: "BackToMainCE", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CountDown.text = String(dDate) + " Days Until next Test"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ------------------------------
    // Read in customize time
    // ------------------------------
    
    @IBOutlet weak var C_time_label: UILabel!
    
    @IBOutlet weak var C_time_sliderOutlet: UISlider!
    @IBAction func C_time_slider(_ sender: UISlider)
    {
        C_time = Int(sender.value)
        C_time_label.text = String(C_time) + " minutes"
    }
    
    
    

}



















