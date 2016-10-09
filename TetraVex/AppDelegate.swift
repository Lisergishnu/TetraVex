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

    /* 
     * Friendly reminder, actions in Xcode 8, Swift 3 have to be described as:
     *      functionNameWithSender:
     * in the Interface Builder.
     */
    @IBAction func newGame(sender: Any?) {
        let pg = PuzzleGenerator(width: currentGameModel.boardWidth, height: currentGameModel.boardHeight, rangeOfNumbers: 1...currentGameModel.currentNumberDigits)
        currentGamePieces = pg.solvedBoard
        let sb = NSStoryboard(name: "Main", bundle: nil)
        let pv : TVGameViewController = sb.instantiateController(withIdentifier: "MainGameViewController") as! TVGameViewController
        pv.solvedBoard = currentGamePieces
        pv.newBoard(2, height: 2)
    }
}

