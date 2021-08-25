//
//  BoardViewController.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Modified by Alessandro Vinciguerra
//
//  Copyright © 2016-2021 Marco Benzi Tobar
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
  
  // MARK: - Properties
  
  public var viewModel: TVGameViewModel? {
    didSet {
      self.prepareBoard()
    }
  }
  private var currentPiecesOnBoard : [TVPieceView] = []
  private var timer: Timer?
  private var visiblePieces : [TVPieceView]?
  
  // MARK: - IB Outlets
  
  @IBOutlet weak var boardAreaBox: TVBoardView!
  @IBOutlet weak var templatePieceView: TVPieceView!
  @IBOutlet weak var boardHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var boardWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var timerLabel: NSTextField!

  // MARK: - Public API
  
  public func prepareBoard() {
    guard let width = viewModel?.boardWidth, let height = viewModel?.boardHeight else {
      return
    }
    
    // Refresh autolayout
    let pw = templatePieceView.frame.width
    let ph = templatePieceView.frame.height
    
    boardWidthConstraint.constant = pw*CGFloat(width)
    boardHeightConstraint.constant = ph*CGFloat(height)
    
    /* Generate and shuffle new pieces */
    /* Also delete previous pieces */
    for pv in currentPiecesOnBoard {
      pv.removeFromSuperview()
    }

    visiblePieces = [TVPieceView]()
    for i in 0..<width {
      for j in 0..<height {
        let nfr = templatePieceView.frame.offsetBy(dx: pw*CGFloat(i), dy: -ph*CGFloat(j))
        let pv : TVPieceView = TVPieceView(frame: nfr)
        pv.autoresizingMask = [NSView.AutoresizingMask.maxXMargin, NSView.AutoresizingMask.minYMargin]
        currentPiecesOnBoard.append(pv)
        pv.pieceModel = viewModel?.solvedBoardPiece(at: i, and: j)
        pv.delegate = self
        self.view.addSubview(pv)
        visiblePieces?.append(pv)
      }
    }
    
    //start timing the game
    if timer != nil {
      timer?.invalidate()
      timer = nil
    }
    timer = Timer.scheduledTimer(
      timeInterval: 1,
      target: self,
      selector: #selector(tick),
      userInfo: nil,
      repeats: true)
    
    viewModel?.resetTimer()
  }
  
  func checkPiece(with pv:TVPieceView,at dropOffPosition:NSPoint) {
    guard let viewModel = self.viewModel else {
      return
    }
    
    /* Determine the position of view inside the grid */
    if boardAreaBox.frame.contains(dropOffPosition) {
      let i : Int = Int((dropOffPosition.x - boardAreaBox.frame.origin.x) / pv.frame.width)
      let j : Int = Int((dropOffPosition.y - boardAreaBox.frame.origin.y) / pv.frame.height)
      
      if viewModel.addToBoard(piece: pv.pieceModel!, at: i, and: j) {
        pv.frame.origin.x = CGFloat(i)*pv.frame.width + boardAreaBox.frame.origin.x
        pv.frame.origin.y = CGFloat(j)*pv.frame.height + boardAreaBox.frame.origin.y
        pv.pieceModel?.isOnBoard = true
        
        if viewModel.isGameFinished {
          timer?.invalidate()
          timer = nil
          viewModel.saveScore()
        }
      } else {
        let randomSource = GKARC4RandomSource()
        var newOrigin = templatePieceView.frame.origin
        newOrigin.x +=  CGFloat(Int.random(0...100,randomSource: randomSource))
        newOrigin.y -=  CGFloat(Int.random(0...100,randomSource: randomSource))
        pv.animator().setFrameOrigin(newOrigin)
      }
    }
  }
  
  //MARK: - Timing
  
  @objc func tick() {
    if let secondsPassed = viewModel?.incrementTimer() {
      timerLabel.stringValue = TVHighScores.timeToString(secondsPassed)
    }
  }
  
  // MARK: Changing the piece text style
  
  func setTextStyle(to style:TVPieceModel.TextStyle) {
    guard let pieces = visiblePieces else {
      return
    }
    textStyle(for: pieces, style)
  }
  
  func textStyle(for pieces:[TVPieceView],_ style: TVPieceModel.TextStyle) {
    for piece in pieces {
      guard var model = piece.pieceModel else {
        continue
      }
      model.textStyle = style
      piece.pieceModel = model
      piece.needsDisplay = true
    }
  }
  
}

extension TVGameViewController : TVPieceViewDelegate {
  func wasLiftedFromBoard(piece: TVPieceView) {
    viewModel?.removeFromBoard(piece: piece)
    
    guard let layer = piece.layer else {
      return
    }
    layer.shadowColor = NSColor.black.cgColor
    layer.shadowOpacity = 0.75
    layer.shadowOffset = CGSize(width: 5,height: 10)
    layer.shadowRadius = 10
  }
  
  func wasDropped(piece: TVPieceView, at: NSPoint) {
    checkPiece(with: piece, at: at)
    guard let layer = piece.layer else {
      return
    }
    layer.shadowOpacity = 0.0
  }
}
