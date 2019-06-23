//
// TVBoardModel.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Foundation

open class TVBoardModel {
  
  // MARK: - Properties
  open var board : [[TVPieceModel?]]
  open var boardWidth : Int = 0
  open var boardHeight : Int = 0
  open var startedPlaying : Bool = false
  
  // MARK: - Initializer
  public init(width: Int, height: Int) {
    board = Array(repeating: Array(repeating: nil, count: height), count: width)
    boardWidth = width
    boardHeight = height
  }
  
  // MARK: - Board manipulation
  open func addPieceToBoard(_ piece: TVPieceModel, x: Int, y: Int) -> Bool {
    if !(0 ... board.count-1 ~= x && 0 ... board[0].count-1 ~= y) {
      return false
    }
    
    if board[x][y] != nil {
      return false
    }
    
    var leftP :TVPieceModel? = nil
    if 0 ... board.count-1 ~= x-1 && 0 ... board[0].count-1 ~= y {
      leftP = board[x-1][y]
    }
    var rightP :TVPieceModel? = nil
    if 0 ... board.count-1 ~= x+1 && 0 ... board[0].count-1 ~= y {
      rightP = board[x+1][y]
    }
    var topP :TVPieceModel? = nil
    if 0 ... board.count-1 ~= x && 0 ... board[0].count-1 ~= y+1 {
      topP = board[x][y+1]
    }
    var botP :TVPieceModel? = nil
    if 0 ... board.count-1 ~= x && 0 ... board[0].count-1 ~= y-1 {
      botP = board[x][y-1]
    }
    
    if leftP != nil && leftP?.rightValue != piece.leftValue {
      return false
    }
    
    if rightP != nil && rightP?.leftValue != piece.rightValue {
      return false
    }
    
    if topP != nil && topP?.bottomValue != piece.topValue {
      return false
    }
    
    if botP != nil && botP?.topValue != piece.bottomValue {
      return false
    }
    
    board[x][y] = piece
    if startedPlaying == false {
      startedPlaying = true
    }
    return true
  }
  
  open func removePieceFromBoard(_ piece:TVPieceModel) -> Bool {
    for i in 0..<boardWidth {
      for j in 0..<boardHeight {
        if board[i][j] != nil && board[i][j]! == piece {
          board[i][j] = nil
          return true
        }
      }
    }
    return false
  }
  
  open func isCompleted() -> Bool {
    for a in board {
      for p in a {
        if p == nil {
          return false
        }
      }
    }
    return true
  }
}
