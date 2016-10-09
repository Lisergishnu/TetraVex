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
    public static func random(_ range: ClosedRange<Int> ) -> Int
    {
        var offset = 0
        
        if range.lowerBound < 0   // allow negative ranges
        {
            offset = abs(range.lowerBound)
        }
        
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}

open class PuzzleGenerator {
    
    // MARK: - Properties
    open var solvedBoard : [[PieceModel]]
    
    // MARK: - Initialization
    public init(width: Int, height: Int, rangeOfNumbers: ClosedRange<Int>) {
        solvedBoard = Array(repeating: Array(repeating: PieceModel(top: 0, left: 0, bottom: 0, right: 0), count: width), count: width)
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
                solvedBoard[i][j] = p
            }
        }
    }
}
