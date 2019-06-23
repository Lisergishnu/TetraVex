//
//  PuzzleGenerator.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Foundation
import GameplayKit

extension Int
{
  public static func random(_ range: ClosedRange<Int>, randomSource: GKRandomSource ) -> Int
  {
    var offset = 0
    
    if range.lowerBound < 0   // allow negative ranges
    {
      offset = abs(range.lowerBound)
    }
    
    let mini = Int(range.lowerBound + offset)
    let maxi = Int(range.upperBound   + offset)
    
    return Int(mini + randomSource.nextInt(upperBound: maxi - mini)) - offset
  }
}

open class TVPuzzleGenerator {
  
  // MARK: - Properties
  open var solvedBoard : [[TVPieceModel]]
  var source : GKARC4RandomSource
  
  // MARK: - Initialization
  public init(width: Int, height: Int, rangeOfNumbers: ClosedRange<Int>, seed: Data? = nil){
    if seed == nil {
      self.source = GKARC4RandomSource()
    } else {
      self.source = GKARC4RandomSource(seed: seed!)
    }
    solvedBoard = Array(repeating: Array(repeating:TVPieceModel(top: 0, left: 0, bottom: 0, right: 0), count: width), count: width)
    for i in 0..<width {
      for j in 0..<height {
        var p = solvedBoard[i][j]
        if j > 0 {
          p.bottomValue = (solvedBoard[i][j-1]).topValue
        } else {
          p.bottomValue = Int.random(rangeOfNumbers, randomSource: source)
        }
        if i > 0 {
          p.leftValue = (solvedBoard[i-1][j]).rightValue
        } else {
          p.leftValue = Int.random(rangeOfNumbers, randomSource: source)
        }
        p.rightValue = Int.random(rangeOfNumbers, randomSource: source)
        p.topValue = Int.random(rangeOfNumbers, randomSource: source)
        solvedBoard[i][j] = p
      }
    }
  }
}
