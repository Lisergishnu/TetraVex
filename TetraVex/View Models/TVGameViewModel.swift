//
//  TVGameViewModel.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 25-08-21.
//
//  Copyright © 2021 Marco Benzi Tobar
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

import Foundation
import TetraVexKit

final class TVGameViewModel {
  
  // MARK: - Properties
  
  private var currentGameModel : TVGameModel
  private var boardModel: TVBoardModel
  private var solvedBoard : [[TVPieceModel]]
  private var secondsPassed: Int = 0
  private var scores: TVHighScores?
  
  // MARK: - Initialization
  
  init(with gameModel: TVGameModel) {
    self.currentGameModel = gameModel
    self.scores = TVHighScores.read()
    let pg = TVPuzzleGenerator(
      width: currentGameModel.boardWidth,
      height: currentGameModel.boardHeight,
      rangeOfNumbers: 0...currentGameModel.currentNumberDigits
    )

    self.solvedBoard = pg.solvedBoard
    
    self.boardModel = TVBoardModel(
      width: self.currentGameModel.boardWidth,
      height: self.currentGameModel.boardHeight
    )
  }
  
  // MARK: - Public API
  
  // MARK: Game
  
  public var isGameFinished: Bool {
    get {
      return boardModel.isCompleted()
    }
  }
  
  // MARK: Board
  
  func addToBoard(piece p: TVPieceModel,at x: Int, and y: Int) -> Bool {
    return boardModel.addPieceToBoard(p, x: x, y: y)
  }
  
  func removeFromBoard(piece p:TVPieceView) {
    if boardModel.removePieceFromBoard(p.pieceModel!) {
      p.pieceModel!.isOnBoard = false
    }
  }
  
  func solvedBoardPiece(at i:Int,and j: Int) -> TVPieceModel {
    return solvedBoard[i][j]
  }
  
  public var boardWidth: Int {
    get {
      return self.boardModel.boardWidth
    }
  }
  
  public var boardHeight: Int {
    get {
      return self.boardModel.boardHeight
    }
  }
  
  // MARK: Scores
  
  public func saveScore() {
    let size = "\(self.boardWidth)x\(self.boardHeight)"
    self.scores?.scores?[size]?[NSDate()] = self.secondsPassed
    self.scores?.save()
  }
  
  // MARK: Timer
  
  func resetTimer() {
    self.secondsPassed = 0;
  }
  
  func incrementTimer() -> Int {
    self.secondsPassed = self.secondsPassed + 1
    return self.secondsPassed;
  }
  
}
