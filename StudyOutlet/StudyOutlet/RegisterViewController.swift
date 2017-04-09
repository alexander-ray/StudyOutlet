//
//  RegisterViewController.swift
//  StudyOutlet
//
//  Created by Alex Ray on 4/9/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Response to "Register"
    @IBAction func sendCredentials (_ sender: UIButton) {
        // Setup
        let username = usernameField.text
        let password = passwordField.text
        let url = "https://studyoutlet.herokuapp.com/api/register"
        parameters["username"] = username
        parameters["password"] = password
        
        // Request with url, JWT, and parameters
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseString { response in
            // Reset
            parameters["username"] = ""
            parameters["password"] = ""
            
            // Convert response to string
            do {
                // If credentials are valid, go to login
                if (response.response?.statusCode == 200) {
                    // Go to menu
                    self.performSegue(withIdentifier: "Login", sender: self)
                }
                // Else, try again
                else {
                    self.usernameField.text = ""
                    self.usernameField.becomeFirstResponder()
                    self.passwordField.text = ""
                }
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    // Response to "Back to Login"
    @IBAction func goToLogin(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Login", sender: self)
    }
}
