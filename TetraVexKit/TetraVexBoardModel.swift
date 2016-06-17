//
//  TetraVexBoardModel.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Foundation

class TetraVexBoardModel {
    
    // MARK: - Properties
    var board : [[PieceModel?]]
    
    // MARK: - Initializer
    init(width: Int, height: Int) {
        board = Array(count: width, repeatedValue: Array(count:height, repeatedValue: nil))
    }
    
    // MARK: - Board manipulation
    func addPieceToBoard(piece: PieceModel, x: Int, y: Int) -> Bool {
        if !(0 ... board.count-1 ~= x && 0 ... board[0].count-1 ~= y) {
            return false
        }
        
        var leftP : PieceModel? = nil
        if 0 ... board.count-1 ~= x-1 && 0 ... board[0].count-1 ~= y {
            leftP = board[x-1][y]
        }
        var rightP : PieceModel? = nil
        if 0 ... board.count-1 ~= x+1 && 0 ... board[0].count-1 ~= y {
            rightP = board[x+1][y]
        }
        var topP : PieceModel? = nil
        if 0 ... board.count-1 ~= x && 0 ... board[0].count-1 ~= y+1 {
            topP = board[x][y+1]
        }
        var botP : PieceModel? = nil
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
        return true
    }
    
    func isCompleted() -> Bool {
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