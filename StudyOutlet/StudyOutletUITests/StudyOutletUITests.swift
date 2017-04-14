//
//  StudyOutletUITests.swift
//  StudyOutletUITests
//
//  Created by Bill on 4/1/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import XCTest

class StudyOutletUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Basic "good" input for a login
    // Should continue to main menu
    func testLoginFieldPositive1() {
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let loginButton = app.buttons["LoginButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText("alex@alex.com")
        passwordTextField.tap()
        passwordTextField.typeText("1Alex")
        
        loginButton.tap()
        XCTAssert(app.images["GRE_Title.png"].exists)
    }
    // Another "good" input
    func testLoginFieldPositive2() {
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let loginButton = app.buttons["LoginButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText("a.nonymous@example.com")
        passwordTextField.tap()
        passwordTextField.typeText("1Alex")
        
        loginButton.tap()
        XCTAssert(app.images["GRE_Title.png"].exists)
    }
    // Another "good" input
    func testLoginFieldPositive3() {
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let loginButton = app.buttons["LoginButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText("name+tag@example.com")
        passwordTextField.tap()
        passwordTextField.typeText("1Alex")
        
        loginButton.tap()
        XCTAssert(app.images["GRE_Title.png"].exists)
    }


    // Empty input fields
    // Should not go to Main Menu
    func testLoginFieldNegative1() {
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let loginButton = app.buttons["LoginButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText("")
        passwordTextField.tap()
        passwordTextField.typeText("")
        
        loginButton.tap()
        XCTAssert(!app.images["GRE_Title.png"].exists)
    }

}
