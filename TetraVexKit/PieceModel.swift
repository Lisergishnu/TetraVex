//
//  PieceModel.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016 Marco Benzi Tobar. All rights reserved.
//

import Foundation

struct PieceModel {
    
    // MARK: - Properties
    var topValue : Int
    var leftValue : Int
    var bottomValue : Int
    var rightValue : Int
    
    // MARK: - Initializer
    init(top: Int, left: Int, bottom: Int, right: Int) {
        topValue = top
        leftValue = left
        bottomValue = bottom
        rightValue = right
    }
}