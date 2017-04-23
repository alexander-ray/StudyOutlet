//
//  LoginViewController.swift
//  StudyOutlet
//
//  Created by Alex Ray on 4/8/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let defaults = UserDefaults.standard

var headers = [
    "Content-Type": "application/x-www-form-urlencoded",
    "Authorization": "Bearer " + (defaults.string(forKey: "api_access_key") ?? "-1") // Set access key from user defaults, -1 if doesn't exist
]
var parameters = [
    "email": "",
    "password": ""
]

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendCredentials (_ sender: UIButton) {
        let email = usernameField.text
        let password = passwordField.text
        let url = "https://studyoutlet.herokuapp.com/api/login"
        parameters["email"] = email
        parameters["password"] = password
        
        // Request with url, JWT, and parameters
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseString { response in
            // Reset
            parameters["email"] = ""
            parameters["password"] = ""

            // Convert response to string
            if let key = response.value {
                do {
                    print(response.description)
                    // If credentials are valid
                    if (response.response?.statusCode == 200 && response.description != "SUCCESS: Invalid Credentials" && response.description != "SUCCESS: Missing username or password") {
                        print(response.description)
                        defaults.set(key, forKey: "api_access_key")
                        // Update authorization header for API calls
                        headers["Authorization"] = "Bearer " + key
                        // Go to menu
                        self.performSegue(withIdentifier: "MainMenu", sender: self)
                    }
                    else {
                        // Set up "invalid login" alert
                        let alert = UIAlertController(title: "Incorrect Login Credentials", message: "Please try again", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                        {
                            (result : UIAlertAction) -> Void in
                            self.usernameField.text = ""
                            self.usernameField.becomeFirstResponder()
                            self.passwordField.text = ""
                        }
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func goToRegister(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Register", sender: self)
    }
}
