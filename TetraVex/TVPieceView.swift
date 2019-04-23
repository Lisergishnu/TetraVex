//
//  TVPieceView.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 20-09-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Cocoa
import TetraVexKit

protocol TVPieceViewDelegate {
    func wasLiftedFromBoard(piece:TVPieceView)
    func wasDropped(piece:TVPieceView, at: NSPoint)
}

@IBDesignable
class TVPieceView : NSView, NSAccessibilityButton {
    var pieceModel :TVPieceModel? {
        didSet{
            guard let model = pieceModel else {
                return
            }
            bufferImage = drawTetraVex(with: model)
        }
    }
    var isBeingDragged : Bool = false
    var lastDraggedPosition : NSPoint = NSPoint()
    
    @IBInspectable var backgroundColor : NSColor = #colorLiteral(red: 0.7480000257, green: 0.7480000257, blue: 0.7480000257, alpha: 1)
    @IBInspectable var roundedRectRadius : CGFloat = 0
    @IBInspectable var insetStrokeColor : NSColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    @IBInspectable var insetStrokeLineWidth : CGFloat = 3
    @IBInspectable var insetOffset: CGFloat = 3
    @IBInspectable var insetShadowColor: NSColor = .gray
    @IBInspectable var outerStrokeColor : NSColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

    @IBInspectable var textColor : NSColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    @IBInspectable var fontSize : CGFloat = 24
    
    var bufferImage : NSImage? = nil
    var delegate : TVPieceViewDelegate? = nil
    
    // MARK: - Dragging operations
    override func mouseDown(with event: NSEvent) {
        guard let pieceModel = pieceModel else {
            return
        }
        
        if pieceModel.boltedInPlace == false {
            isBeingDragged = true
            lastDraggedPosition = self.convert(event.locationInWindow, to: self)
            let i = superview?.subviews.firstIndex(of: self)
            var svs = superview!.subviews
            if (i != svs.count-1) {
                svs.swapAt(i!, svs.count-1)
                superview?.subviews = svs
            }
            if pieceModel.isOnBoard {
                delegate?.wasLiftedFromBoard(piece: self)
            }
            NSCursor.closedHand.push()
            self.needsDisplay = true
        }
    }
    
    func offsetLocation(by dx:CGFloat, dy:CGFloat) {
        self.setNeedsDisplay(self.bounds);
        let invertDeltaY : CGFloat = self.isFlipped ? -1.0 : 1.0;
        self.frame = self.frame.offsetBy(dx: dx, dy: dy*invertDeltaY)
        self.setNeedsDisplay(self.bounds)
    }
    
    override func mouseDragged(with event: NSEvent) {
        if (isBeingDragged) {
            let p : NSPoint = self.convert(event.locationInWindow, to: self)
            offsetLocation(by: p.x - lastDraggedPosition.x, dy: p.y - lastDraggedPosition.y)
            lastDraggedPosition = p
            self.autoscroll(with: event)
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        if isBeingDragged {
            let dropPosition : NSPoint = superview!.convert(event.locationInWindow, to: nil)
            delegate?.wasDropped(piece: self, at: dropPosition)
            isBeingDragged = false
            NSCursor.pop()
            self.needsDisplay = true
        }
    }
    
    // MARK: - Accessibility functions
    override func accessibilityLabel() -> String? {
        return "TetraVex Piece"
    }
    
    // MARK: - Drawing operations
    
    func drawStringCenteredAt(_ center: NSPoint, str: String, attribs: [NSAttributedString.Key: Any]?) {
        let nsstr = NSString(string: str)
        let b = nsstr.boundingRect(with: NSSize(width: 300,height: 300), options: NSString.DrawingOptions.usesFontLeading, attributes: attribs)
        var dCenter = center
        dCenter.x = center.x - b.width/2
        dCenter.y = center.y - b.height/2
        nsstr.draw(at: dCenter, withAttributes: attribs)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        guard let image = bufferImage else {
            return
        }
        image.draw(in: self.bounds)
    }
    
    func drawTetraVex(with pieceModel: TVPieceModel) -> NSImage {
        let image = NSImage(size: self.bounds.size)
        image.lockFocus()
        let pathRect = self.bounds
        let path = NSBezierPath(roundedRect: pathRect,
                                xRadius: roundedRectRadius,
                                yRadius: roundedRectRadius)
        
        // Background Fill
        backgroundColor.setFill()
        path.fill()
        
        // Inner X lines
        NSGraphicsContext.saveGraphicsState()
        
        drawInsetLine(NSPoint(x:pathRect.origin.x,
                              y:pathRect.origin.y+insetOffset),
                      to: NSPoint(x: pathRect.maxX,
                                  y: pathRect.maxY+insetOffset),
                      color: insetShadowColor,
                      lineWidth: insetStrokeLineWidth)
        drawInsetLine(NSPoint(x:pathRect.minX - insetOffset,
                              y:pathRect.maxY),
                      to: NSPoint(x: pathRect.maxX - insetOffset,
                                  y: pathRect.minY),
                      color: insetShadowColor,
                      lineWidth: insetStrokeLineWidth)
        
        drawInsetLine(pathRect.origin,
                      to: NSPoint(x: pathRect.maxX, y: pathRect.maxY),
                      color: insetStrokeColor,
                      lineWidth: insetStrokeLineWidth)
        drawInsetLine(NSPoint(x:pathRect.minX,y:pathRect.maxY),
                      to: NSPoint(x: pathRect.maxX, y: pathRect.minY),
                      color: insetStrokeColor,
                      lineWidth: insetStrokeLineWidth)
        
        NSGraphicsContext.restoreGraphicsState()
        
        // Outer stroke
        let outerStrokeLineWidth : CGFloat = 10
        let outerStrokeOffset : CGFloat = 2
        
        drawInsetLine(NSPoint(x:pathRect.maxX - outerStrokeOffset,
                              y:pathRect.minY + outerStrokeOffset),
                      to: NSPoint(x: pathRect.maxX - outerStrokeOffset,
                                  y: pathRect.maxY + outerStrokeOffset),
                      color: .gray,
                      lineWidth: outerStrokeLineWidth)
        drawInsetLine(NSPoint(x:pathRect.minX + outerStrokeOffset,
                              y:pathRect.minY - outerStrokeOffset),
                      to: NSPoint(x: pathRect.minX + outerStrokeOffset,
                                  y: pathRect.maxY + outerStrokeOffset),
                      color: .white,
                      lineWidth: outerStrokeLineWidth)
        drawInsetLine(NSPoint(x:pathRect.minX - outerStrokeOffset,
                              y:pathRect.maxY - outerStrokeOffset),
                      to: NSPoint(x: pathRect.maxX + outerStrokeOffset,
                                  y: pathRect.maxY - outerStrokeOffset),
                      color: .white,
                      lineWidth: outerStrokeLineWidth)
        drawInsetLine(NSPoint(x:pathRect.minX + outerStrokeOffset,
                              y:pathRect.minY + outerStrokeOffset),
                      to: NSPoint(x: pathRect.maxX - outerStrokeOffset,
                                  y: pathRect.minY + outerStrokeOffset),
                      color: .gray,
                      lineWidth: outerStrokeLineWidth)
        
        
        path.lineWidth = 1
        outerStrokeColor.setStroke()
        path.stroke()
        
        
        // Text
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let font = NSFont(name: "Helvetica-Bold", size: fontSize*(pathRect.height/80.0)) ?? NSFont.systemFont(ofSize: fontSize*(pathRect.height/80.0))
        let shadow = NSShadow()
        shadow.shadowColor = .white
        shadow.shadowOffset = NSSize(width: -1, height: 1)
        shadow.shadowBlurRadius = 1
        let attribs : [NSAttributedString.Key:Any] =
            [NSAttributedString.Key.font:font,
             NSAttributedString.Key.strokeColor: textColor,
             NSAttributedString.Key.shadow: shadow,
             NSAttributedString.Key.paragraphStyle:
                paragraphStyle]
        
        
        let ptop = NSPoint(x: pathRect.width*0.5 + pathRect.minX,
                           y: pathRect.height*0.80 + pathRect.minY)
        let pbot = NSPoint(x: pathRect.width*0.5 + pathRect.minX,
                           y: pathRect.height*0.20 + pathRect.minY)
        let pleft = NSPoint(x: pathRect.width*0.20 + pathRect.minX,
                            y: pathRect.height*0.5 + pathRect.minY)
        let pright = NSPoint(x: pathRect.width*0.80 + pathRect.minX,
                             y: pathRect.height*0.5 + pathRect.minY)
        
        drawStringCenteredAt(ptop, str: "\(pieceModel.topValue)", attribs: attribs)
        drawStringCenteredAt(pbot, str: "\(pieceModel.bottomValue)", attribs: attribs)
        drawStringCenteredAt(pleft, str: "\(pieceModel.leftValue)", attribs: attribs)
        drawStringCenteredAt(pright, str: "\(pieceModel.rightValue)", attribs: attribs)
        image.unlockFocus()
        return image
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
        pieceModel = TVPieceModel(top: 1, left: 2, bottom: 3, right: 4)
    }
}
