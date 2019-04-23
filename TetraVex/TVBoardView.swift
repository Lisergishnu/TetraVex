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
    @IBInspectable var insetStrokeLineWidth : CGFloat = 3
    
    var model : TVBoardModel? = nil {
        didSet {
            guard let model = model else {
                return
            }
            prepareBoard(with: model)
        }
    }

    
    override func mouseUp(with event: NSEvent) {
            
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let path = NSBezierPath(roundedRect: self.bounds, xRadius: 3, yRadius: 3)
        
        NSColor.gray.setFill()
        NSColor.black.setStroke()
        
        path.fill()
        path.stroke()
        
        guard let model = model else {
            return
        }
        
        let pathSquare = NSBezierPath(
            rect: NSRect(
                x: 0,
                y: 0,
                width: pieceWidth,
                height: pieceHeight)
        )
        
        for i in 0..<model.boardWidth {
            for j in 0..<model.boardHeight {
                drawInsetLine(
                    CGPoint(x: CGFloat(i+1)*pieceWidth, y: CGFloat(j)*pieceHeight),
                    to: CGPoint(x: CGFloat(i+1)*pieceWidth, y: CGFloat(j+1)*pieceHeight),
                    color: .white)
                drawInsetLine(
                    CGPoint(x: CGFloat(i)*pieceWidth, y: CGFloat(j)*pieceHeight),
                    to: CGPoint(x: CGFloat(i+1)*pieceWidth, y: CGFloat(j)*pieceHeight),
                    color: .white)
                
                drawInsetLine(
                    CGPoint(x: CGFloat(i)*pieceWidth, y: CGFloat(j)*pieceHeight),
                    to: CGPoint(x: CGFloat(i)*pieceWidth, y: CGFloat(j+1)*pieceHeight),
                    color: .gray)
                drawInsetLine(
                    CGPoint(x: CGFloat(i)*pieceWidth, y: CGFloat(j+1)*pieceHeight),
                    to: CGPoint(x: CGFloat(i+1)*pieceWidth, y: CGFloat(j+1)*pieceHeight),
                    color: .gray)
            }
        }
    }
    
    func drawInsetLine(_ from: CGPoint, to: CGPoint, color: NSColor, lineWidth:CGFloat = 1) {
        let innerPath = NSBezierPath()
        innerPath.lineWidth = insetStrokeLineWidth
        innerPath.move(to: from)
        innerPath.line(to: to)
        color.setStroke()
        innerPath.stroke()
    }
    
    override func prepareForInterfaceBuilder() {
        model = TVBoardModel(width: 2, height: 2)
    }
    
    func prepareBoard(with model:TVBoardModel) {
        let topY = self.frame.origin.y + self.frame.height
        let newBox = CGRect(x: self.frame.origin.x,
                            y: topY - (pieceHeight)*CGFloat(model.boardHeight),
                            width: pieceWidth*CGFloat(model.boardWidth),
                            height: pieceHeight*CGFloat(model.boardHeight))
        self.frame = newBox
        self.bounds = NSRect(x: 0,
                             y: 0,
                             width: frame.width,
                             height: frame.height)
        
    }
}
