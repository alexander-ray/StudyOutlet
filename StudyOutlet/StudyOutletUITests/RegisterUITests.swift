//
//  RegisterUITests.swift
//  StudyOutlet
//
//  Created by Alex Ray on 4/14/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import XCTest

class RegisterUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        // Go to register page to start testing
        let registerButton = app.buttons["RegisterButton"]
        registerButton.tap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: Login
    
    // Basic "good" input for a register
    // Should continue to main menu
    func testPositive1() {
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let registerButton = app.buttons["RegisterButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText("alex@alex.com")
        passwordTextField.tap()
        passwordTextField.typeText("1Alex")
        
        registerButton.tap()
        XCTAssert(!app.buttons["LoginButton"].exists)
    }
}
