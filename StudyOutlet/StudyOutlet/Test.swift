//
//  Test.swift
//  StudyOutlet
//
//  Created by Alex Ray on 4/4/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//
import UIKit
import SwiftyJSON
import Alamofire

class Test {
    // Struct to represent question
    struct question {
        var question: UIImage
        var solution: UIImage
        var answer: String
        var subject: String
        var topic: String
    }
    
    // Test properties
    var testName = ""
    var testSize = 0
    var questionArray = [question]() // Array of questions that make up the test
    // Initializer function
    init(testName: String) {
        self.testName = testName
        //self.testSize = testSize
    }
    
    // Get current units for given task
    // Closure (anonymous function)
    // Returns array of questions
    func getQuestions(completionHandler: @escaping ([question]?) -> Void) {
        // Endpoint url
        let url = "https://studyoutlet.herokuapp.com/question/questions"
        
        var arr = [question]()
        
        // Request to url
        Alamofire.request(url).responseJSON { response in
            if((response.result.value) != nil) { // If there are available units
                let swifty = JSON(response.result.value!) // SwiftyJSON conversion
                // For all units retrieved, add to array of unit elements
                // Set given_task.unitArray = getUnits()
                for i in (0..<swifty.count) {
                    // Get images from base64
                    let q = Helper.base64ToImage(input: swifty[i]["question"].stringValue)
                    let s = Helper.base64ToImage(input: swifty[i]["solution"].stringValue)
                    // Create question
                    let data = question(question: q, solution: s, answer: swifty[i]["answer"].stringValue, subject: swifty[i]["subject"].stringValue, topic:swifty[i]["topic"].stringValue)
                    // Add to array
                    arr.append(data)
                }
            }
            completionHandler(arr)
        }
    }
}
