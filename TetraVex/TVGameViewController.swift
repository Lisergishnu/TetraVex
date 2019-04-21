//
//  BoardViewController.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Modified by Alessandro Vinciguerra
//
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//
//  Copyright © 2017 Arc676/Alessandro Vinciguerra
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation (version 3)
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Cocoa
import TetraVexKit
import GameplayKit

class TVGameViewController: NSViewController
{
	var solvedBoard : [[TVPieceModel]]? = nil
	@IBOutlet weak var boardAreaBox: TVBoardView!
	@IBOutlet weak var templatePieceView: TVPieceView!
	var currentPiecesOnBoard : [TVPieceView] = []
	var boardModel: TVBoardModel?
	var delegate : AppDelegate?
    @IBOutlet weak var boardHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var boardWidthConstraint: NSLayoutConstraint!
    
	//timing
	var timer: Timer?
	var secondsPassed: Int = 0
	@IBOutlet weak var timerLabel: NSTextField!

	//scores
	var scores: TVHighScores?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		delegate = NSApplication.shared.delegate as? AppDelegate
		scores = TVHighScores.read()
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

        // Refresh autolayout
        boardWidthConstraint.constant = pw*CGFloat(width)
        boardHeightConstraint.constant = ph*CGFloat(height)
        
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
					pv.autoresizingMask = [NSView.AutoresizingMask.maxXMargin, NSView.AutoresizingMask.minYMargin]
					currentPiecesOnBoard.append(pv)
					pv.pieceModel = solvedBoard![i][j]
                    pv.delegate = self
					self.view.addSubview(pv)
				}
			}

		}

		//start timing the game
		if timer != nil {
			timer?.invalidate()
			timer = nil
		}
		secondsPassed = 0
		timer = Timer.scheduledTimer(
			timeInterval: 1,
			target: self,
			selector: #selector(tick),
			userInfo: nil,
			repeats: true)
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
				if boardModel!.isCompleted() {
					timer?.invalidate()
					timer = nil

					let size = "\(boardModel!.boardWidth)x\(boardModel!.boardHeight)"
					scores?.scores?[size]?[NSDate()] = secondsPassed
					scores?.save()
				}
			} else {
                let randomSource = GKARC4RandomSource()
                pv.frame.origin.x = templatePieceView.frame.origin.x + CGFloat(Int.random(0...100,randomSource: randomSource))
                pv.frame.origin.y = templatePieceView.frame.origin.y - CGFloat(Int.random(0...100,randomSource: randomSource))
			}
		}
	}

	//MARK: - Timing
	@objc func tick() {
		secondsPassed += 1
		timerLabel.stringValue = TVHighScores.timeToString(secondsPassed)
	}

}

extension TVGameViewController : TVPieceViewDelegate {
    func wasLiftedFromBoard(piece: TVPieceView) {
        removeFromBoard(piece: piece)
    }
    
    func wasDropped(piece: TVPieceView, at: NSPoint) {
        checkPiece(with: piece, at: at)
    }
}
