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
    // when the username is not in the database
    // Should back to login page
    func testPositive1() {
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let registerButton = app.buttons["RegisterButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText("test@test.com")
        passwordTextField.tap()
        passwordTextField.typeText("1Aa")
        
        registerButton.tap()
        XCTAssert(app.buttons["LoginButton"].exists)
    }
    
    // Basic "good" input for a register
    // when the username is not a correct email address
    // Should stay at register page
    func testNegative1() {
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let registerButton = app.buttons["RegisterButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText("not_a_correct_email_address")
        passwordTextField.tap()
        passwordTextField.typeText("1Aa")
        
        registerButton.tap()
        XCTAssert(!app.buttons["LoginButton"].exists)
    }
    
    // Basic "good" input for a register
    // when the password only has numbers
    // Should stay at register page
    func testNegative2() {
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let registerButton = app.buttons["RegisterButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText("test_password_has_only_numbers@test.com")
        passwordTextField.tap()
        passwordTextField.typeText("111")
        
        registerButton.tap()
        XCTAssert(!app.buttons["LoginButton"].exists)
    }
    
    // Basic "good" input for a register
    // when the password only has lower case letters
    // Should stay at register page
    func testNegative3() {
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let registerButton = app.buttons["RegisterButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText("test_password_has_only_lowercase@test.com")
        passwordTextField.tap()
        passwordTextField.typeText("aaa")
        
        registerButton.tap()
        XCTAssert(!app.buttons["LoginButton"].exists)
    }
    
    // Basic "good" input for a register
    // when the password has no upper case letter
    // Should stay at register page
    func testNegative4() {
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let registerButton = app.buttons["RegisterButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText("test_password_has_no_uppercase@test.com")
        passwordTextField.tap()
        passwordTextField.typeText("123abc")
        
        registerButton.tap()
        XCTAssert(!app.buttons["LoginButton"].exists)
    }
    
    // Basic "good" input for a register
    // when the username already in the database, it won't let people re-register
    // Should stay at register page
    func testNegative5() {
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





















