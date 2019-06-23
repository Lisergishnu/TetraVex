//
//  AppDelegate.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016 Marco Benzi Tobar
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

  var currentGameModel : TVGameModel = TVGameModel()
  var currentGamePieces : [[TVPieceModel]]?
  var gameStarted: Bool = false

  var optionMenu: NSMenuItem? {
    return NSApplication.shared.mainMenu?
      .item(withTitle: "Options")
  }

  //MARK: - Resizing board
  func setBoardSize(width: Int, height: Int) {
    currentGameModel.boardWidth = width
    currentGameModel.boardHeight = height
  }

  // MARK: Board size menu manipulation
  var sizeSubMenu: NSMenuItem? {
    return optionMenu?.submenu?.item(withTitle: "Size")
  }

  @IBAction func setBoardTo2x2(sender: Any?) {
    setBoardSize(width: 2, height: 2)
    let sm = sizeSubMenu?.submenu
    sm?.item(withTitle: "2x2")?.state = NSControl.StateValue(rawValue: 1)
    sm?.item(withTitle: "3x3")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "4x4")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "5x5")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "6x6")?.state = NSControl.StateValue(rawValue: 0)
  }

  @IBAction func setBoardTo3x3(sender: Any?) {
    setBoardSize(width: 3, height: 3)
    let sm = sizeSubMenu?.submenu
    sm?.item(withTitle: "2x2")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "3x3")?.state = NSControl.StateValue(rawValue: 1)
    sm?.item(withTitle: "4x4")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "5x5")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "6x6")?.state = NSControl.StateValue(rawValue: 0)
  }

  @IBAction func setBoardTo4x4(sender: Any?) {
    setBoardSize(width: 4, height: 4)
    let sm = sizeSubMenu?.submenu
    sm?.item(withTitle: "2x2")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "3x3")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "4x4")?.state = NSControl.StateValue(rawValue: 1)
    sm?.item(withTitle: "5x5")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "6x6")?.state = NSControl.StateValue(rawValue: 0)
  }

  @IBAction func setBoardTo5x5(sender: Any?) {
    setBoardSize(width: 5, height: 5)
    let sm = sizeSubMenu?.submenu
    sm?.item(withTitle: "2x2")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "3x3")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "4x4")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "5x5")?.state = NSControl.StateValue(rawValue: 1)
    sm?.item(withTitle: "6x6")?.state = NSControl.StateValue(rawValue: 0)
  }

  @IBAction func setBoardTo6x6(sender: Any?) {
    setBoardSize(width: 6, height: 6)
    let sm = sizeSubMenu?.submenu
    sm?.item(withTitle: "2x2")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "3x3")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "4x4")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "5x5")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "6x6")?.state = NSControl.StateValue(rawValue: 1)
  }


  //MARK: - Changing range of digits
  func setNumberOfDigits(num :Int) {
    currentGameModel.currentNumberDigits = num
  }

  // MARK: Number of digits menu manipulation
  var numberOfDigitsSubMenu: NSMenuItem? {
    return optionMenu?.submenu?.item(withTitle: "Digits")
  }
  @IBAction func setNumberOfDigitsTo6(sender: Any?) {
    setNumberOfDigits(num: 5)
    let sm = numberOfDigitsSubMenu?.submenu
    sm?.item(withTitle: "6")?.state = NSControl.StateValue(rawValue: 1)
    sm?.item(withTitle: "7")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "8")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "9")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "10")?.state = NSControl.StateValue(rawValue: 0)
  }

  @IBAction func setNumberOfDigitsTo7(sender: Any?) {
    setNumberOfDigits(num: 6)
    let sm = numberOfDigitsSubMenu?.submenu
    sm?.item(withTitle: "6")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "7")?.state = NSControl.StateValue(rawValue: 1)
    sm?.item(withTitle: "8")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "9")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "10")?.state = NSControl.StateValue(rawValue: 0)
  }

  @IBAction func setNumberOfDigitsTo8(sender: Any?) {
    setNumberOfDigits(num: 7)
    let sm = numberOfDigitsSubMenu?.submenu
    sm?.item(withTitle: "6")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "7")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "8")?.state = NSControl.StateValue(rawValue: 1)
    sm?.item(withTitle: "9")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "10")?.state = NSControl.StateValue(rawValue: 0)
  }

  @IBAction func setNumberOfDigitsTo9(sender: Any?) {
    setNumberOfDigits(num: 8)
    let sm = numberOfDigitsSubMenu?.submenu
    sm?.item(withTitle: "6")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "7")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "8")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "9")?.state = NSControl.StateValue(rawValue: 1)
    sm?.item(withTitle: "10")?.state = NSControl.StateValue(rawValue: 0)
  }

  @IBAction func setNumberOfDigitsTo10(sender: Any?) {
    setNumberOfDigits(num: 9)
    let sm = numberOfDigitsSubMenu?.submenu
    sm?.item(withTitle: "6")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "7")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "8")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "9")?.state = NSControl.StateValue(rawValue: 0)
    sm?.item(withTitle: "10")?.state = NSControl.StateValue(rawValue: 1)
  }


  @IBAction func setTextStyleToDigits(sender: Any?) {
    guard let controller = NSApplication.shared.mainWindow?.contentViewController as? TVGameViewController else {
      return
    }

    optionMenu?.submenu?.item(withTitle: "Numbers")?.state = .on
    optionMenu?.submenu?.item(withTitle: "Letters")?.state = .off
    optionMenu?.submenu?.item(withTitle: "Greek")?.state = .off

    controller.setTextStyle(to: .digits)
  }

  @IBAction func setTextStyleToLetters(sender: Any?) {
    guard let controller = NSApplication.shared.mainWindow?.contentViewController as? TVGameViewController else {
      return
    }

    optionMenu?.submenu?.item(withTitle: "Numbers")?.state = .off
    optionMenu?.submenu?.item(withTitle: "Letters")?.state = .on
    optionMenu?.submenu?.item(withTitle: "Greek")?.state = .off

    controller.setTextStyle(to: .letters)
  }
  @IBAction func setTextStyleToGreekSymbols(sender: Any?) {
    guard let controller = NSApplication.shared.mainWindow?.contentViewController as? TVGameViewController else {
      return
    }

    optionMenu?.submenu?.item(withTitle: "Numbers")?.state = .off
    optionMenu?.submenu?.item(withTitle: "Letters")?.state = .off
    optionMenu?.submenu?.item(withTitle: "Greek")?.state = .on

    controller.setTextStyle(to: .greekSymbols)
  }

  //MARK: - Game actions
  @IBAction func newGame(sender: Any?) {
    let pg = TVPuzzleGenerator(width: currentGameModel.boardWidth, height: currentGameModel.boardHeight, rangeOfNumbers: 0...currentGameModel.currentNumberDigits)
    currentGamePieces = pg.solvedBoard
    let pv : TVGameViewController = NSApplication.shared.mainWindow?.contentViewController as! TVGameViewController
    pv.solvedBoard = currentGamePieces
    pv.newBoard(currentGameModel.boardWidth, height: currentGameModel.boardHeight)

    gameStarted = true
  }
}

//MARK: - Menu validation
extension AppDelegate: NSMenuItemValidation {
  func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
    if !gameStarted {
      if 10...36 ~= menuItem.tag {
        return false
      }
    }
    return true
  }
}
