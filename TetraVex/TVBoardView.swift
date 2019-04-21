//
//  TVBoardView.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 10-10-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Foundation
import Cocoa
import TetraVexKit

@IBDesignable
class TVBoardView: NSView {
    
    @IBInspectable var pieceWidth : CGFloat = 90
    @IBInspectable var pieceHeight : CGFloat = 90
    
    var model : TVBoardModel? = nil

    
    override func mouseUp(with event: NSEvent) {
            
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        
    }
}
