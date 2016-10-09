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

    var solvedBoard : [[PieceModel]]? = nil
    @IBOutlet weak var boardAreaBox: NSBox!
    @IBOutlet weak var templatePieceView: PieceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        
        /* Generate and shuffle new pieces */
        
    }
}

