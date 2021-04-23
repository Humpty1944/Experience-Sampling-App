//
//  DiscreteSliderQuestion.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation

class DsicreteSliderQuestion: Codable {
     init(id: Int, discreteSliderMinValue: Int, discreteSliderMaxValue: Int, scaleText: [String], questionType: String, questionText: String, questionSubtext: String, instructionText: String, questionNumber: Int) {
        self.id = id
        self.discreteSliderMinValue = discreteSliderMinValue
        self.discreteSliderMaxValue = discreteSliderMaxValue
        self.scaleTexts = scaleText
        self.questionType = questionType
        self.questionText = questionText
        self.questionSubtext = questionSubtext
        self.instructionText = instructionText
        self.questionNumber = questionNumber
    }
    
    let id: Int
   
    let discreteSliderMinValue: Int
    let discreteSliderMaxValue:Int
    let scaleTexts: [String]
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
//    case DiscreteSliderMinValue
//    case DiscreteSliderMaxValue
//    case ScaleText
////  let name: String
//  }
}
