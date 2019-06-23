//
// TVPieceModel.swift
//  TetraVex
//
//  Created by Marco Benzi Tobar on 17-06-16.
//  Copyright © 2016 Marco Benzi Tobar
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

public struct TVPieceModel {
  
  // MARK: - Properties
  public var topValue : Int
  public var leftValue : Int
  public var bottomValue : Int
  public var rightValue : Int
  public var boltedInPlace : Bool = false
  public var isOnBoard : Bool = false
  
  // MARK: - Setting a different piece letter style
  public enum TextStyle {
    case digits
    case letters
    case greekSymbols
  }
  
  public var textStyle : TextStyle = .digits
  
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
