//
//  PieceModel.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Foundation

public struct PieceModel {
    
    // MARK: - Properties
    public var topValue : Int
    public var leftValue : Int
    public var bottomValue : Int
    public var rightValue : Int
    
    // MARK: - Initializer
    public init(top: Int, left: Int, bottom: Int, right: Int) {
        topValue = top
        leftValue = left
        bottomValue = bottom
        rightValue = right
    }
}