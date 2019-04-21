//
//  TVPieceView.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 20-09-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Cocoa
import TetraVexKit

@IBDesignable
class TVPieceView : NSView, NSAccessibilityButton {
    var pieceModel :TVPieceModel?
    var isBeingDragged : Bool = false
    var lastDraggedPosition : NSPoint = NSPoint()
    var controller : TVGameViewController?
    
    @IBInspectable var backgroundColor : NSColor = #colorLiteral(red: 0.7480000257, green: 0.7480000257, blue: 0.7480000257, alpha: 1)
    @IBInspectable var roundedRectRadius : CGFloat = 2
    @IBInspectable var innerStrokeColor : NSColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    @IBInspectable var innerStrokeLineWidth : CGFloat = 1
    @IBInspectable var outerStrokeColor : NSColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

    @IBInspectable var textColor : NSColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    @IBInspectable var fontSize : CGFloat = 18
    
    
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
                controller?.removeFromBoard(piece: self)
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
            controller?.checkPiece(with: self, at: dropPosition)
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
    
    func drawStringCenteredAt(_ center: NSPoint, str: NSString, attribs: [NSAttributedString.Key: Any]?) {
        let b = str.boundingRect(with: NSSize(width: 300,height: 300), options: NSString.DrawingOptions.usesFontLeading, attributes: attribs)
        var dCenter = center
        dCenter.x = center.x - b.width/2
        dCenter.y = center.y - b.height/2
        str.draw(at: dCenter, withAttributes: attribs)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        guard let pieceModel = pieceModel else {
            return
        }
        
        let pathRect = NSInsetRect(self.bounds, 5, 5)
        let path = NSBezierPath(roundedRect: pathRect,
                                xRadius: roundedRectRadius,
                                yRadius: roundedRectRadius)
        
        // Background Fill
        backgroundColor.setFill()
        path.fill()
        
        // Inner X lines
        NSGraphicsContext.saveGraphicsState()
        var shadow = NSShadow()
        shadow.shadowColor = .black
        shadow.shadowOffset = NSSize(width: 0, height: 3)
        shadow.shadowBlurRadius = 1

        drawInsetLine(pathRect.origin,
                      to: NSPoint(x: pathRect.maxX, y: pathRect.maxY),
                      color: innerStrokeColor,
                      lineWidth: innerStrokeLineWidth,
                      shadow: shadow)
        drawInsetLine(NSPoint(x:pathRect.minX,y:pathRect.maxY),
                      to: NSPoint(x: pathRect.maxX, y: pathRect.minY),
                      color: innerStrokeColor,
                      lineWidth: innerStrokeLineWidth,
                      shadow: shadow)
        
        NSGraphicsContext.restoreGraphicsState()
        
        // Outer stroke
        outerStrokeColor.setStroke();
        path.lineWidth = 1
        path.stroke()
        
        // Text
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let font = NSFont(name: "Helvetica-Bold", size: fontSize*(pathRect.height/80.0)) ?? NSFont.systemFont(ofSize: fontSize*(pathRect.height/80.0))
        shadow = NSShadow()
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
        
        var s = NSString(format: "%d", pieceModel.topValue)
        drawStringCenteredAt(ptop, str: s, attribs: attribs)
        s = NSString(format: "%d", pieceModel.bottomValue)
        drawStringCenteredAt(pbot, str: s, attribs: attribs)
        s = NSString(format: "%d", pieceModel.leftValue)
        drawStringCenteredAt(pleft, str: s, attribs: attribs)
        s = NSString(format: "%d", pieceModel.rightValue)
        drawStringCenteredAt(pright, str: s, attribs: attribs)
    }
    
    func drawInsetLine(_ from: CGPoint, to: CGPoint, color: NSColor, lineWidth:CGFloat = 1, shadow: NSShadow? = nil) {
        let innerPath = NSBezierPath()
        innerPath.lineWidth = innerStrokeLineWidth
        innerPath.move(to: from)
        innerPath.line(to: to)
        color.setStroke()
        innerPath.stroke()
        shadow?.set()
    }
    
    override func prepareForInterfaceBuilder() {
        pieceModel = TVPieceModel(top: 1, left: 2, bottom: 3, right: 4)
    }
}
