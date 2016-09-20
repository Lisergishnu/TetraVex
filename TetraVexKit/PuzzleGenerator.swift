//
//  PuzzleGenerator.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Foundation

extension Int
{
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}

class PuzzleGenerator {
    
    // MARK: - Properties
    var solvedBoard : [[PieceModel]]
    
    // MARK: - Initialization
    init(width: Int, height: Int, rangeOfNumbers: Range<Int>) {
        solvedBoard = Array(count: width, repeatedValue: Array(count: width, repeatedValue: PieceModel(top: 0, left: 0, bottom: 0, right: 0)))
        
        for i in 0..<width {
            for j in 0..<height {
                var p = solvedBoard[i][j]
                if j > 0 {
                    p.bottomValue = (solvedBoard[i][j-1]).topValue
                } else {
                  p.bottomValue = Int.random(rangeOfNumbers)
                }
                if i > 0 {
                    p.leftValue = (solvedBoard[i-1][j]).rightValue
                } else {
                    p.leftValue = Int.random(rangeOfNumbers)
                }
                p.rightValue = Int.random(rangeOfNumbers)
                p.topValue = Int.random(rangeOfNumbers)
            }
        }
    }
}