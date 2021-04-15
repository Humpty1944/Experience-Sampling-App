//
//  AffectGridQuestion.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation

import UIKit
struct AffectGridQuestion: Codable{
    
    let ID:Int
    let QuestionID: Int?
    let MinX:Int
    let MaxX: Int
    let MinY: Int
    let MaxY: Int
    let DelimiterCount: Int?
    let IsGridVisible: Bool
    let UpperXText: String
    let LowerXText: String
    let UpperYText: String
    let LowerYText: String
    let LeftUpperSquareText: String
    let RightUpperSquareText: String
    let LeftLowerSquareText: String
    let RightLowerSquareText: String
    
    enum CodingKeys: String, CodingKey {
      case ID
      case QuestionID
      case MinX
      case MaxX
      case MaxY
      case MinY
      case DelimiterCount
      case IsGridVisible
      case UpperXText
      case LowerXText
      case UpperYText
      case LowerYText
      case LeftUpperSquareText
      case RightUpperSquareText
      case LeftLowerSquareText
      case RightLowerSquareText
    }
}
