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

    
    var currentGamePieces : [[PieceModel]]?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func startNewGame(_ width: Int, height: Int, digits: Int) {
        let pg = PuzzleGenerator(width: width, height: height, rangeOfNumbers: 1...digits)
        currentGamePieces = pg.solvedBoard
        
    }
}

