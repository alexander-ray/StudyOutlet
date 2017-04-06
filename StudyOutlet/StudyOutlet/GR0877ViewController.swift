//
//  GR0877ViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/4/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

class GR0877ViewController: UIViewController {
    
    var minutes = 170
    var timer = Timer()
    
    @IBOutlet weak var CountDown: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CountDown.text = String(dDate) + " Days Until next Test"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Button_BackToOPEMenu(_ sender: Any)
    {
        performSegue(withIdentifier: "BackToOPEMenu", sender: self)
    }
    
    
    
    
    @IBOutlet weak var countMinute: UILabel!
    
    @IBOutlet weak var StartImageOutlet: UIImageView!
    @IBOutlet weak var StopImageOutlet: UIImageView!
    
    @IBOutlet weak var StartButtonOutlet: UIButton!
    @IBAction func StartAction(_ sender: Any)
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GR0877ViewController.counter), userInfo: nil, repeats: true)
        
        StartImageOutlet.isHidden = true
        StartButtonOutlet.isHidden = true
    }
    
    func counter()
    {
        minutes -= 1
        countMinute.text = String(minutes) + " min"
        
        if (minutes == 0)
        {
            timer.invalidate()
            StartImageOutlet.isHidden = false
            StartButtonOutlet.isHidden = false
        }
    }

    @IBOutlet weak var StopButtonOutlet: UIButton!
    @IBAction func StopAction(_ sender: Any)
    {
        timer.invalidate()
        minutes = 170
        countMinute.text = "170 min"
        StartImageOutlet.isHidden = false
        StartButtonOutlet.isHidden = false
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
