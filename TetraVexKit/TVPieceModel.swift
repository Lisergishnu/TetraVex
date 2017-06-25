//
// TVPieceModel.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Foundation

public struct TVPieceModel {
    
    // MARK: - Properties
    public var topValue : Int
    public var leftValue : Int
    public var bottomValue : Int
    public var rightValue : Int
    public var boltedInPlace : Bool = false
    public var isOnBoard : Bool = false
    
    // MARK: - Initializer
    public init(top: Int, left: Int, bottom: Int, right: Int) {
        topValue = top
        leftValue = left
        bottomValue = bottom
        rightValue = right
    }
    
    // MARK: - Operations
    public static func == (left: TVPieceModel, right: TVPieceModel) -> Bool {
        return  (left.topValue == right.topValue) &&
                (left.bottomValue == right.bottomValue) &&
                (left.leftValue == right.leftValue) &&
                (left.rightValue == right.rightValue)
    }
    
    public static func != (left: TVPieceModel, right: TVPieceModel) -> Bool {
        return !(left == right)
    }
}
