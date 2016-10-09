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

    var currentGameModel : TVGameModel = TVGameModel()
    var currentGamePieces : [[PieceModel]]?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    //MARK: - Resizing board
    func setBoardSize(width: Int, height: Int) {
        currentGameModel.boardWidth = width
        currentGameModel.boardHeight = height
    }
    
    func setBoardTo2x2(sender: Any?) {
        setBoardSize(width: 2, height: 2)
        let sm = NSApplication.shared().mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Size")?.submenu
        sm?.item(withTitle: "2x2")?.state = 1
        sm?.item(withTitle: "3x3")?.state = 0
        sm?.item(withTitle: "4x4")?.state = 0
        sm?.item(withTitle: "5x5")?.state = 0
        sm?.item(withTitle: "6x6")?.state = 0
    }
    
    func setBoardTo3x3(sender: Any?) {
        setBoardSize(width: 3, height: 3)
        let sm = NSApplication.shared().mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Size")?.submenu
        sm?.item(withTitle: "2x2")?.state = 0
        sm?.item(withTitle: "3x3")?.state = 1
        sm?.item(withTitle: "4x4")?.state = 0
        sm?.item(withTitle: "5x5")?.state = 0
        sm?.item(withTitle: "6x6")?.state = 0
    }
    
    func setBoardTo4x4(sender: Any?) {
        setBoardSize(width: 4, height: 4)
        let sm = NSApplication.shared().mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Size")?.submenu
        sm?.item(withTitle: "2x2")?.state = 0
        sm?.item(withTitle: "3x3")?.state = 0
        sm?.item(withTitle: "4x4")?.state = 1
        sm?.item(withTitle: "5x5")?.state = 0
        sm?.item(withTitle: "6x6")?.state = 0
    }
    
    func setBoardTo5x5(sender: Any?) {
        setBoardSize(width: 5, height: 5)
        let sm = NSApplication.shared().mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Size")?.submenu
        sm?.item(withTitle: "2x2")?.state = 0
        sm?.item(withTitle: "3x3")?.state = 0
        sm?.item(withTitle: "4x4")?.state = 0
        sm?.item(withTitle: "5x5")?.state = 1
        sm?.item(withTitle: "6x6")?.state = 0
    }
    
    func setBoardTo6x6(sender: Any?) {
        setBoardSize(width: 6, height: 6)
        let sm = NSApplication.shared().mainMenu?
            .item(withTitle: "Options")?.submenu?.item(withTitle: "Size")?.submenu
        sm?.item(withTitle: "2x2")?.state = 0
        sm?.item(withTitle: "3x3")?.state = 0
        sm?.item(withTitle: "4x4")?.state = 0
        sm?.item(withTitle: "5x5")?.state = 0
        sm?.item(withTitle: "6x6")?.state = 1
    }
    
    //MARK: - Changing range of digits
    func setNumberOfDigits(num :Int) {
        currentGameModel.currentNumberDigits = num
    }
    
    func setNumberOfDigitsTo6(sender: Any?) {
        setNumberOfDigits(num: 5)
    }
    
    func setNumberOfDigitsTo7(sender: Any?) {
        setNumberOfDigits(num: 6)
    }
    
    func setNumberOfDigitsTo8(sender: Any?) {
        setNumberOfDigits(num: 7)
    }
    
    func setNumberOfDigitsTo9(sender: Any?) {
        setNumberOfDigits(num: 8)
    }
    
    func setNumberOfDigitsTo10(sender: Any?) {
        setNumberOfDigits(num: 9)
    }
    
    //MARK: - Game actions
    /* 
     * Friendly reminder, First Responder actions in Xcode 8, Swift 3
     * have to be described as:
     *      functionNameWithSender:
     * in the Interface Builder.
     */
    func newGame(sender: Any?) {
        let pg = PuzzleGenerator(width: currentGameModel.boardWidth, height: currentGameModel.boardHeight, rangeOfNumbers: 0...currentGameModel.currentNumberDigits)
        currentGamePieces = pg.solvedBoard
        let pv : TVGameViewController = NSApplication.shared().mainWindow?.contentViewController as! TVGameViewController
        pv.solvedBoard = currentGamePieces
        pv.newBoard(currentGameModel.boardWidth, height: currentGameModel.boardHeight)
    }
}

