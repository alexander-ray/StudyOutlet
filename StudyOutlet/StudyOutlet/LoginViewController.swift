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

// Headers for API requests
var headers = [
    "Content-Type": "application/x-www-form-urlencoded",
    "Authorization": "Bearer " + (defaults.string(forKey: "api_access_key") ?? "-1") // Set access key from user defaults, -1 if doesn't exist
]
// Parameters for API requests
var parameters = [
    "email": "",
    "password": ""
]

// Login view controller
// Login page shown on app open
class LoginViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    // Load view
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Action on "login" button push
    @IBAction func sendCredentials (_ sender: UIButton) {
        // Setup
        let email = usernameField.text
        let password = passwordField.text
        let url = "https://studyoutlet.herokuapp.com/api/login"
        
        // Setting parameters for request
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
                    // If credentials are valid
                    if (response.response?.statusCode == 200 && response.description != "SUCCESS: Invalid Credentials" && response.description != "SUCCESS: Missing username or password") {
                        // Set api key for future use
                        defaults.set(key, forKey: "api_access_key")
                        // Update authorization header for API calls
                        headers["Authorization"] = "Bearer " + key
                        // Go to menu
                        self.performSegue(withIdentifier: "MainMenu", sender: self)
                    }
                    else {
                        // Set up "invalid date" alert
                        let alert = UIAlertController(title: "Incorrect Login Credentials", message: "Please try again", preferredStyle: UIAlertControllerStyle.alert)
                        // If incorrect credentials, send alert and reset fields
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
    
    // Registration button push
    @IBAction func goToRegister(_ sender: UIButton) {
        // Go to register page
        self.performSegue(withIdentifier: "Register", sender: self)
    }
}
