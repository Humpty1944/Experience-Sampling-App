//
//  AffectGridQuestion.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation

import UIKit
class AffectGridQuestion: Codable{
     init(id: Int, minX: Int, maxX: Int, minY: Int, maxY: Int, delimiterCount: Int?, isGridVisible: Bool, upperXText: String, lowerXText: String, upperYText: String, lowerYText: String, leftUpperSquareText: String, rightUpperSquareText: String, leftLowerSquareText: String, rightLowerSquareText: String, questionType: String, questionText: String, questionSubtext: String, instructionText: String, questionNumber: Int) {
        self.id = id
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
        self.delimiterCount = delimiterCount
        self.isGridVisible = isGridVisible
        self.upperXText = upperXText
        self.lowerXText = lowerXText
        self.upperYText = upperYText
        self.lowerYText = lowerYText
        self.leftUpperSquareText = leftUpperSquareText
        self.rightUpperSquareText = rightUpperSquareText
        self.leftLowerSquareText = leftLowerSquareText
        self.rightLowerSquareText = rightLowerSquareText
        self.questionType = questionType
        self.questionText = questionText
        self.questionSubtext = questionSubtext
        self.instructionText = instructionText
        self.questionNumber = questionNumber
    }
    
    
    let id:Int
    let minX:Int
    let maxX: Int
    let minY: Int
    let maxY: Int
    let delimiterCount: Int?
    let isGridVisible: Bool
    let upperXText: String?
    let lowerXText: String?
    let upperYText: String?
    let lowerYText: String?
    let leftUpperSquareText: String?
    let rightUpperSquareText: String?
    let leftLowerSquareText: String?
    let rightLowerSquareText: String?
    let questionType: String?
    let questionText: String?
    let questionSubtext: String?
    let instructionText: String?
    let questionNumber: Int

    
//    enum CodingKeys: String, CodingKey {
//      case ID
//      case QuestionID
//      case MinX
//      case MaxX
//      case MaxY
//      case MinY
//      case DelimiterCount
//      case IsGridVisible
//      case UpperXText
//      case LowerXText
//      case UpperYText
//      case LowerYText
//      case LeftUpperSquareText
//      case RightUpperSquareText
//      case LeftLowerSquareText
//      case RightLowerSquareText
//    }
}
