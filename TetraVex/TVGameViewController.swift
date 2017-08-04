//
//  BoardViewController.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Cocoa
import TetraVexKit

class TVGameViewController: NSViewController {
    
    var solvedBoard : [[TVPieceModel]]? = nil
    @IBOutlet weak var boardAreaBox: TVBoardView!
    @IBOutlet weak var templatePieceView: TVPieceView!
    var currentPiecesOnBoard : [TVPieceView] = []
    var boardModel: TVBoardModel?
    var delegate : AppDelegate?
    
    override func viewDidLoad() {
        if #available(OSX 10.10, *) {
            super.viewDidLoad()
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
        delegate = NSApplication.shared().delegate as? AppDelegate
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func newBoard(_ width: Int, height: Int) {
        /* Resize board outline */
        let pw  = templatePieceView.frame.width
        let ph  = templatePieceView.frame.height
        let topY = boardAreaBox.frame.origin.y + boardAreaBox.frame.height
        
        let newBox = CGRect(x: boardAreaBox.frame.origin.x,
                            y: topY - (ph)*CGFloat(height),
                            width: pw*CGFloat(width),
                            height: ph*CGFloat(height))
        boardAreaBox.frame = newBox
        boardAreaBox.bounds = NSRect(x: 0, y: 0, width: boardAreaBox.frame.width, height: boardAreaBox.frame.height)
        
        boardModel = TVBoardModel(width: width, height: height)
        
        /* Generate and shuffle new pieces */
        /* Also delete previous pieces */
        for pv in currentPiecesOnBoard {
            pv.removeFromSuperview()
        }
        if ((solvedBoard) != nil) {
            for i in 0..<width {
                for j in 0..<height {
                    let nfr = templatePieceView.frame.offsetBy(dx: pw*CGFloat(i), dy: -ph*CGFloat(j))
                    let pv : TVPieceView = TVPieceView(frame: nfr)
                    pv.autoresizingMask = [.viewMaxXMargin, .viewMinYMargin]
                    currentPiecesOnBoard.append(pv)
                    pv.pieceModel = solvedBoard![i][j]
                    pv.controller = self
                    self.view.addSubview(pv)
                }
            }
            
        }
    }
    
    func removeFromBoard(piece p:TVPieceView) -> Bool {
        if boardModel!.removePieceFromBoard(p.pieceModel!) {
            p.pieceModel!.isOnBoard = false
            return true
        }
        return false
    }
    
    func checkPiece(with pv:TVPieceView,at dropOffPosition:NSPoint) {
        /* Determine the position of view inside the grid */
        if boardAreaBox.frame.contains(dropOffPosition) {
            let i : Int = Int((dropOffPosition.x - boardAreaBox.frame.origin.x) / pv.frame.width)
            let j : Int = Int((dropOffPosition.y - boardAreaBox.frame.origin.y) / pv.frame.height)
            
            if boardModel!.addPieceToBoard(pv.pieceModel!, x: i, y: j) {
                pv.frame.origin.x = CGFloat(i)*pv.frame.width + boardAreaBox.frame.origin.x
                pv.frame.origin.y = CGFloat(j)*pv.frame.height + boardAreaBox.frame.origin.y
                pv.pieceModel?.isOnBoard = true
            } else {
                pv.frame.origin.x = templatePieceView.frame.origin.x + CGFloat(Int.random(0...100))
                pv.frame.origin.y = templatePieceView.frame.origin.y - CGFloat(Int.random(0...100))
            }
        }
    }
}

