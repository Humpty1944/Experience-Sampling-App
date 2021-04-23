//
//  SliderQuestion.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation

import UIKit

class SliderQuestion: Codable {
     init(id: Int, sliderMinValue: Int, sliderMaxValue: Int, isDiscrete: Int, leftText: String, rightString: String, questionType: String, questionText: String, questionSubtext: String, instructionText: String, questionNumber: Int) {
        self.id = id
        self.sliderMinValue = sliderMinValue
        self.sliderMaxValue = sliderMaxValue
        self.isDiscrete = isDiscrete
        self.leftText = leftText
        self.rightString = rightString
        self.questionType = questionType
        self.questionText = questionText
        self.questionSubtext = questionSubtext
        self.instructionText = instructionText
        self.questionNumber = questionNumber
    }
    
    let id: Int
  
    let sliderMinValue: Int
    let sliderMaxValue:Int
    let isDiscrete: Int
    let leftText: String
    let rightString: String
    let questionType: String
    let questionText: String
    let questionSubtext: String
    let instructionText: String
    let questionNumber: Int
//  let name: String
//  let imageUrl: String
//  let rating: CGFloat
//  let reviewCount: Int
//  let price: String
//  let displayPhone: String
//  let photos: [String]
//  let location: Location

//  enum CodingKeys: String, CodingKey {
//    case ID
//    case QuestionID
//    case SliderMinValue
//    case SliderMaxValue
//    case IsDiscrete
//    case LeftText
//    case RightString
////  let name: String
//  }
}

//struct Location: Codable {
//  let displayAddress: [String]
//
//  enum CodingKeys: String, CodingKey {
//    case displayAddress = "display_address"
//  }
//}
