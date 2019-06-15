//
//  AppDelegate.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Cocoa
import TetraVexKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  // MARK: - Setting a different letter view
  enum TextStyle {
    case digits
    case letters
    case greekSymbols
  }
    
    var currentGameModel : TVGameModel = TVGameModel()
    var currentGamePieces : [[TVPieceModel]]?
    
    //MARK: - Resizing board
    func setBoardSize(width: Int, height: Int) {
        currentGameModel.boardWidth = width
        currentGameModel.boardHeight = height
    }
    /*
     * Reminder, First Responder actions have to marked with @IBAction
     * to appear in the Interface Builder.
     */
    @IBAction func setBoardTo2x2(sender: Any?) {
        setBoardSize(width: 2, height: 2)
        let sm = NSApplication.shared.mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Size")?.submenu
        sm?.item(withTitle: "2x2")?.state = NSControl.StateValue(rawValue: 1)
        sm?.item(withTitle: "3x3")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "4x4")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "5x5")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "6x6")?.state = NSControl.StateValue(rawValue: 0)
    }
    
    @IBAction func setBoardTo3x3(sender: Any?) {
        setBoardSize(width: 3, height: 3)
        let sm = NSApplication.shared.mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Size")?.submenu
        sm?.item(withTitle: "2x2")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "3x3")?.state = NSControl.StateValue(rawValue: 1)
        sm?.item(withTitle: "4x4")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "5x5")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "6x6")?.state = NSControl.StateValue(rawValue: 0)
    }
    
    @IBAction func setBoardTo4x4(sender: Any?) {
        setBoardSize(width: 4, height: 4)
        let sm = NSApplication.shared.mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Size")?.submenu
        sm?.item(withTitle: "2x2")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "3x3")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "4x4")?.state = NSControl.StateValue(rawValue: 1)
        sm?.item(withTitle: "5x5")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "6x6")?.state = NSControl.StateValue(rawValue: 0)
    }
    
    @IBAction func setBoardTo5x5(sender: Any?) {
        setBoardSize(width: 5, height: 5)
        let sm = NSApplication.shared.mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Size")?.submenu
        sm?.item(withTitle: "2x2")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "3x3")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "4x4")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "5x5")?.state = NSControl.StateValue(rawValue: 1)
        sm?.item(withTitle: "6x6")?.state = NSControl.StateValue(rawValue: 0)
    }
    
    @IBAction func setBoardTo6x6(sender: Any?) {
        setBoardSize(width: 6, height: 6)
        let sm = NSApplication.shared.mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Size")?.submenu
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
    
    @IBAction func setNumberOfDigitsTo6(sender: Any?) {
        setNumberOfDigits(num: 5)
        let sm = NSApplication.shared.mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Digits")?.submenu
        sm?.item(withTitle: "6")?.state = NSControl.StateValue(rawValue: 1)
        sm?.item(withTitle: "7")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "8")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "9")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "10")?.state = NSControl.StateValue(rawValue: 0)
    }
    
    @IBAction func setNumberOfDigitsTo7(sender: Any?) {
        setNumberOfDigits(num: 6)
        let sm = NSApplication.shared.mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Digits")?.submenu
        sm?.item(withTitle: "6")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "7")?.state = NSControl.StateValue(rawValue: 1)
        sm?.item(withTitle: "8")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "9")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "10")?.state = NSControl.StateValue(rawValue: 0)
    }
    
    @IBAction func setNumberOfDigitsTo8(sender: Any?) {
        setNumberOfDigits(num: 7)
        let sm = NSApplication.shared.mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Digits")?.submenu
        sm?.item(withTitle: "6")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "7")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "8")?.state = NSControl.StateValue(rawValue: 1)
        sm?.item(withTitle: "9")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "10")?.state = NSControl.StateValue(rawValue: 0)
    }
    
    @IBAction func setNumberOfDigitsTo9(sender: Any?) {
        setNumberOfDigits(num: 8)
        let sm = NSApplication.shared.mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Digits")?.submenu
        sm?.item(withTitle: "6")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "7")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "8")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "9")?.state = NSControl.StateValue(rawValue: 1)
        sm?.item(withTitle: "10")?.state = NSControl.StateValue(rawValue: 0)
    }
    
    @IBAction func setNumberOfDigitsTo10(sender: Any?) {
        setNumberOfDigits(num: 9)
        let sm = NSApplication.shared.mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Digits")?.submenu
        sm?.item(withTitle: "6")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "7")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "8")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "9")?.state = NSControl.StateValue(rawValue: 0)
        sm?.item(withTitle: "10")?.state = NSControl.StateValue(rawValue: 1)
    }
    
    //MARK: - Game actions
    @IBAction func newGame(sender: Any?) {
        let pg = TVPuzzleGenerator(width: currentGameModel.boardWidth, height: currentGameModel.boardHeight, rangeOfNumbers: 0...currentGameModel.currentNumberDigits)
        currentGamePieces = pg.solvedBoard
        let pv : TVGameViewController = NSApplication.shared.mainWindow?.contentViewController as! TVGameViewController
        pv.solvedBoard = currentGamePieces
        pv.newBoard(currentGameModel.boardWidth, height: currentGameModel.boardHeight)
        
    }
	
}
