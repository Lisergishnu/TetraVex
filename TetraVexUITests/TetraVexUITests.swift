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
  
  /// Tests the proper creation of a board from scratch
  func testNewGame() {
    
    let app = XCUIApplication()
    let menuBarsQuery = app.menuBars
    menuBarsQuery.menuBarItems["Game"].click()
    menuBarsQuery/*@START_MENU_TOKEN@*/.menuItems["New Game"]/*[[".menuBarItems[\"Game\"]",".menus.menuItems[\"New Game\"]",".menuItems[\"New Game\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.click()
    
    let tetravexWindow = app.windows["TetraVex"]
    let tetravexPieceButton = tetravexWindow.children(matching: .button).matching(identifier: "TetraVex Piece").element(boundBy: 0)
    tetravexPieceButton.click()
    tetravexWindow.children(matching: .button).matching(identifier: "TetraVex Piece").element(boundBy: 2).click()
    tetravexWindow.children(matching: .button).matching(identifier: "TetraVex Piece").element(boundBy: 1).click()
    tetravexWindow.children(matching: .button).matching(identifier: "TetraVex Piece").element(boundBy: 3).click()
    
  }
}
