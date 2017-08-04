//
//  TVPieceView.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 20-09-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Cocoa
import TetraVexKit

class TVPieceView : NSView {
    var pieceModel :TVPieceModel?
    var isBeingDragged : Bool = false
    var lastDraggedPosition : NSPoint = NSPoint()
    var controller : TVGameViewController?
    
    // MARK: - Dragging operations
    override func mouseDown(with event: NSEvent) {
        if (pieceModel?.boltedInPlace)! == false {
            isBeingDragged = true
            lastDraggedPosition = self.convert(event.locationInWindow, to: self)
            let i = superview?.subviews.index(of: self)
            var svs = superview!.subviews
            if (i != svs.count-1) {
                swap(&svs[i!],&svs[svs.count-1])
                superview?.subviews = svs
            }
            if pieceModel!.isOnBoard {
                controller?.removeFromBoard(piece: self)
            }
            NSCursor.closedHand().push()
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
    
    // MARK: - Drawing operations
    
    func drawStringCenteredAt(_ center: NSPoint, str: NSString, attribs: [String: AnyObject]?) {
        let b = str.boundingRect(with: NSSize(width: 300,height: 300), options: NSStringDrawingOptions.oneShot, attributes: attribs)
        var dCenter = center
        dCenter.x = center.x - b.width/2
        dCenter.y = center.y - b.height/2
        str.draw(at: dCenter, withAttributes: attribs)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        if (pieceModel != nil) {
            let pathRect = NSInsetRect(self.bounds, 5, 5)
            let path = NSBezierPath(roundedRect: pathRect, xRadius: 2, yRadius: 2)
            path.lineWidth = 2
            
            let shadow = NSShadow()
            shadow.shadowBlurRadius = 1
            
            if isBeingDragged {
                shadow.shadowColor = NSColor.secondarySelectedControlColor
                shadow.shadowOffset = NSSize(width: 5, height: -5)
                shadow.set()
            }
            
            
            NSColor.windowBackgroundColor.setFill()
            NSColor.windowFrameTextColor.setStroke();
            path.fill()
            
            NSGraphicsContext.saveGraphicsState()
            NSColor.windowFrameColor.setStroke()
            NSBezierPath.strokeLine(
                from: pathRect.origin,
                to: NSPoint(x: pathRect.maxX, y: pathRect.maxY)
            )
            NSBezierPath.strokeLine(
                from: NSPoint(x:pathRect.minX,y:pathRect.maxY),
                to: NSPoint(x: pathRect.maxX, y: pathRect.minY)
            )
            
            NSGraphicsContext.restoreGraphicsState()
            
            path.stroke()
            
            let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSCenterTextAlignment
            
            if #available(OSX 10.10, *) {
                shadow.shadowColor = NSColor.tertiaryLabelColor
            } else {
                // Fallback on earlier versions
            }
            shadow.shadowOffset = NSSize(width: 1.5, height: -1.5)
            shadow.shadowBlurRadius = 1
            
            let font = NSFont(name: "Helvetica", size: 18*(pathRect.height/80.0))
            
            let ptop = NSPoint(x: pathRect.width*0.5 + pathRect.minX,
                               y: pathRect.height*0.80 + pathRect.minY)
            let pbot = NSPoint(x: pathRect.width*0.5 + pathRect.minX,
                               y: pathRect.height*0.20 + pathRect.minY)
            let pleft = NSPoint(x: pathRect.width*0.20 + pathRect.minX,
                                y: pathRect.height*0.5 + pathRect.minY)
            let pright = NSPoint(x: pathRect.width*0.80 + pathRect.minX,
                                 y: pathRect.height*0.5 + pathRect.minY)
            
            if #available(OSX 10.10, *) {
                let attribs : [String:AnyObject] =
                    [NSShadowAttributeName:shadow,
                     NSFontAttributeName:font!,
                     NSStrokeColorAttributeName:NSColor.labelColor,
                     NSParagraphStyleAttributeName:paragraphStyle]
                var s = NSString(format: "%d", pieceModel!.topValue)
                drawStringCenteredAt(ptop, str: s, attribs: attribs)
                s = NSString(format: "%d", pieceModel!.bottomValue)
                drawStringCenteredAt(pbot, str: s, attribs: attribs)
                s = NSString(format: "%d", pieceModel!.leftValue)
                drawStringCenteredAt(pleft, str: s, attribs: attribs)
                s = NSString(format: "%d", pieceModel!.rightValue)
                drawStringCenteredAt(pright, str: s, attribs: attribs)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
