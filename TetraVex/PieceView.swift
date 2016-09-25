//
//  PieceView.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 20-09-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Cocoa
import TetraVexKit

class PieceView : NSView {
    var pieceModel : PieceModel?
    var isBeingDragged : Bool = false
    
    func drawStringCenteredAt(center: NSPoint, str: NSString, attribs: [String: AnyObject]?) {
        let b = str.boundingRectWithSize(NSSize(width: 300,height: 300), options: NSStringDrawingOptions.OneShot, attributes: attribs)
        var dCenter = center
        dCenter.x = center.x - b.width/2
        dCenter.y = center.y - b.height/2
        str.drawAtPoint(dCenter, withAttributes: attribs)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        if (pieceModel != nil) {
            let pathRect = NSInsetRect(self.bounds, 5, 5)
            let path = NSBezierPath(roundedRect: pathRect, xRadius: 2, yRadius: 2)
            path.lineWidth = 2
            
            let shadow = NSShadow()
            shadow.shadowBlurRadius = 1
            
            if isBeingDragged {
                shadow.shadowColor = NSColor.secondarySelectedControlColor()
                shadow.shadowOffset = NSSize(width: 5, height: -5)
                shadow.set()
            }
            
            
            NSColor.windowBackgroundColor().setFill()
            NSColor.windowFrameTextColor().setStroke();
            path.fill()
            
            NSGraphicsContext.saveGraphicsState()
            NSColor.windowFrameColor().setStroke()
            NSBezierPath.strokeLineFromPoint(
                pathRect.origin,
                toPoint: NSPoint(x: pathRect.maxX, y: pathRect.maxY)
            )
            NSBezierPath.strokeLineFromPoint(
                NSPoint(x:pathRect.minX,y:pathRect.maxY),
                toPoint: NSPoint(x: pathRect.maxX, y: pathRect.minY)
            )
            
            NSGraphicsContext.restoreGraphicsState()
            
            path.stroke()
            
            let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSCenterTextAlignment
            
            shadow.shadowColor = NSColor.tertiaryLabelColor()
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
            
            let attribs : [String:AnyObject] =
                [NSShadowAttributeName:shadow,
                 NSFontAttributeName:font!,
                 NSStrokeColorAttributeName:NSColor.labelColor(),
                 NSParagraphStyleAttributeName:paragraphStyle]
            
            var s = NSString(format: "%d", pieceModel!.topValue)
            drawStringCenteredAt(ptop, str: s, attribs: attribs)
            s = NSString(format: "%d", pieceModel!.bottomValue)
            drawStringCenteredAt(pbot, str: s, attribs: attribs)
            s = NSString(format: "%d", pieceModel!.leftValue)
            drawStringCenteredAt(pleft, str: s, attribs: attribs)
            s = NSString(format: "%d", pieceModel!.rightValue)
            drawStringCenteredAt(pright, str: s, attribs: attribs)
        }
    }
}
