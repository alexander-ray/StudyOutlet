//
//  OPEViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/1/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

class OPEViewController: UIViewController {

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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
