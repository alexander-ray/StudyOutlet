//
//  DatePickerTests.swift
//  StudyOutlet
//
//  Created by Alex Ray on 4/16/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//

import XCTest

class DatePickerUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        
        // Go to settings page
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        let loginButton = app.buttons["LoginButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText("alex@alex.com")
        passwordTextField.tap()
        passwordTextField.typeText("1Alex")
        
        loginButton.tap()
        
        let settingsButton = app.buttons["SettingsButton"]
        settingsButton.tap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: Login
    
    // Basic "good" input for a register
    // Should continue to main menu
    func testPositive1() {
        let updateButton = app.buttons["UpdateButton"]
        
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "May 19")
        app.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "6")
        app.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "30")
        app.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: "PM")

        updateButton.tap()
        XCTAssert(app.images["GRE_Title.png"].exists)
    }
    
    func testNegative1() {
        let updateButton = app.buttons["UpdateButton"]
        
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Mar 19")
        app.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "6")
        app.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "30")
        app.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: "PM")
        
        updateButton.tap()
        XCTAssert(!app.images["GRE_Title.png"].exists)
    }

}
