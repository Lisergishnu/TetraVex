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
        
    }
}

