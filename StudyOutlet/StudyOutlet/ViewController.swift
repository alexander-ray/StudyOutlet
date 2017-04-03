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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        CountDown.text = String(dDate) + " Days Until next Test"
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
    
}
