//
//  TetraVexUITests.swift
//  TetraVexUITests
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import XCTest

class TetraVexUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        if #available(OSX 10.11, *) {
            XCUIApplication().launch()
        } else {
            // Fallback on earlier versions
        }

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.menuBars.menuBarItems["Game"].click()
        
        let tetravexWindow = app.windows["TetraVex"]
        tetravexWindow.click()
        tetravexWindow.click()
        tetravexWindow.click()
        tetravexWindow.click()
        tetravexWindow.click()
        tetravexWindow.typeKey("q", modifierFlags:.command)
        
    }
    
}
