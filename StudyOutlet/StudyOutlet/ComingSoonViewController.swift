//
//  ComingSoonViewController.swift
//  StudyOutlet
//
//  Created by Bill on 4/4/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit

class ComingSoonViewController: UIViewController {

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
    
    
    @IBAction func BackOne(_ sender: Any)
    {
        performSegue(withIdentifier: "Back1", sender: self)
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
