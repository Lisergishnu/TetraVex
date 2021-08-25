//
//  AppDelegate.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016-2021 Marco Benzi Tobar
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation (version 3)
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Cocoa
import TetraVexKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  // MARK: - Properties
  
  var gameModel: TVGameModel = TVGameModel()

  // MARK: - Resizing board
  
  func setBoardSize(width: Int, height: Int) {
    guard let controller = self.gameViewController  else {
      return
    }
    
    gameModel.boardWidth = width
    gameModel.boardHeight = height
    controller.viewModel = TVGameViewModel(with: gameModel)
  }

  // MARK: Board size menu manipulation

  @IBAction func setBoardTo2x2(sender: Any?) {
    setBoardSize(width: 2, height: 2)
    markBoardSizeSubMenu(to: [1,0,0,0,0])
  }

  @IBAction func setBoardTo3x3(sender: Any?) {
    setBoardSize(width: 3, height: 3)
    markBoardSizeSubMenu(to: [0,1,0,0,0])
  }

  @IBAction func setBoardTo4x4(sender: Any?) {
    setBoardSize(width: 4, height: 4)
    markBoardSizeSubMenu(to: [0,0,1,0,0])
  }

  @IBAction func setBoardTo5x5(sender: Any?) {
    setBoardSize(width: 5, height: 5)
    markBoardSizeSubMenu(to: [0,0,0,1,0])
  }

  @IBAction func setBoardTo6x6(sender: Any?) {
    setBoardSize(width: 6, height: 6)
    markBoardSizeSubMenu(to: [0,0,0,0,1])
  }

  // MARK: - Changing range of digits
  
  func setNumberOfDigits(num :Int) {
    guard let controller = self.gameViewController  else {
      return
    }
    
    gameModel.currentNumberDigits = num
    controller.viewModel = TVGameViewModel(with: gameModel)
  }

  // MARK: Number of digits menu manipulation

  @IBAction func setNumberOfDigitsTo6(sender: Any?) {
    setNumberOfDigits(num: 5)
    markNumOfDigitsSubMenu(to: [1,0,0,0,0])
  }

  @IBAction func setNumberOfDigitsTo7(sender: Any?) {
    setNumberOfDigits(num: 6)
    markNumOfDigitsSubMenu(to: [0,1,0,0,0])
  }

  @IBAction func setNumberOfDigitsTo8(sender: Any?) {
    setNumberOfDigits(num: 7)
    markNumOfDigitsSubMenu(to: [0,0,1,0,0])
  }

  @IBAction func setNumberOfDigitsTo9(sender: Any?) {
    setNumberOfDigits(num: 8)
    markNumOfDigitsSubMenu(to: [0,0,0,1,0])
  }

  @IBAction func setNumberOfDigitsTo10(sender: Any?) {
    setNumberOfDigits(num: 9)
    markNumOfDigitsSubMenu(to: [0,0,0,0,1])
  }
  
  // MARK: - Text style
  
  fileprivate func setTextStyle(to style: TVPieceModel.TextStyle) {
    guard let controller = self.gameViewController else {
      return
    }
    
    controller.setTextStyle(to: style)
  }
  

  @IBAction func setTextStyleToDigits(sender: Any?) {
    markTextStyleSubMenu(to: [1,0,0])
    setTextStyle(to: .digits)
  }

  @IBAction func setTextStyleToLetters(sender: Any?) {
    markTextStyleSubMenu(to: [0,1,0])
    setTextStyle(to: .letters)
  }
  @IBAction func setTextStyleToGreekSymbols(sender: Any?) {
    markTextStyleSubMenu(to: [0,0,1])
    setTextStyle(to: .greekSymbols)
  }

  // MARK: - Game actions
  
  @IBAction func newGame(sender: Any?) {
    guard let controller = self.gameViewController else {
      return;
    }
    
    controller.viewModel = TVGameViewModel(with: self.gameModel)
  }
  
  // MARK: - Helper functions
  
  fileprivate var sizeSubMenu: NSMenuItem? {
    return optionMenu?.submenu?.item(withTitle: "Size")
  }
  
  fileprivate var optionMenu: NSMenuItem? {
    return NSApplication.shared.mainMenu?
      .item(withTitle: "Options")
  }
  
  fileprivate var numberOfDigitsSubMenu: NSMenuItem? {
    return optionMenu?.submenu?.item(withTitle: "Digits")
  }
  
  fileprivate func markBoardSizeSubMenu(to ticks: [Int]) {
    let sm = sizeSubMenu?.submenu
    sm?.item(withTitle: "2x2")?.state = NSControl.StateValue(rawValue: ticks[0])
    sm?.item(withTitle: "3x3")?.state = NSControl.StateValue(rawValue: ticks[1])
    sm?.item(withTitle: "4x4")?.state = NSControl.StateValue(rawValue: ticks[2])
    sm?.item(withTitle: "5x5")?.state = NSControl.StateValue(rawValue: ticks[3])
    sm?.item(withTitle: "6x6")?.state = NSControl.StateValue(rawValue: ticks[4])
  }
  
  fileprivate func markNumOfDigitsSubMenu(to ticks: [Int]) {
    let sm = numberOfDigitsSubMenu?.submenu
    sm?.item(withTitle: "6")?.state = NSControl.StateValue(rawValue: ticks[0])
    sm?.item(withTitle: "7")?.state = NSControl.StateValue(rawValue: ticks[1])
    sm?.item(withTitle: "8")?.state = NSControl.StateValue(rawValue: ticks[2])
    sm?.item(withTitle: "9")?.state = NSControl.StateValue(rawValue: ticks[3])
    sm?.item(withTitle: "10")?.state = NSControl.StateValue(rawValue: ticks[4])
  }
  
  fileprivate func markTextStyleSubMenu(to ticks: [Int]) {
    let sm = optionMenu?.submenu
    sm?.item(withTitle: "Numbers")?.state = NSControl.StateValue(rawValue: ticks[0])
    sm?.item(withTitle: "Letters")?.state = NSControl.StateValue(rawValue: ticks[1])
    sm?.item(withTitle: "Greek")?.state = NSControl.StateValue(rawValue: ticks[2])
  }
  
  fileprivate var gameViewController: TVGameViewController? {
    get {
      return NSApplication.shared.mainWindow?.contentViewController as? TVGameViewController
    }
  }
}

// MARK: - Menu validation

extension AppDelegate: NSMenuItemValidation {
  func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
    if self.gameViewController == nil || 10...36 ~= menuItem.tag {
      return false
    }
    
    return true
  }
}