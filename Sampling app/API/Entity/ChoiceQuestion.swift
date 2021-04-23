//
//  ChoiceQuestion.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation
class ChoiceQuestion:Codable{
     init(id: Int, isSingleChoice: Bool, answers: [String], questionType: String, questionText: String, questionSubtext: String, instructionText: String, questionNumber: Int) {
        self.id = id
        self.isSingleChoice = isSingleChoice
        self.answers = answers
        self.questionType = questionType
        self.questionText = questionText
        self.questionSubtext = questionSubtext
        self.instructionText = instructionText
        self.questionNumber = questionNumber
    }
    
    let id: Int
    let isSingleChoice:Bool
    let answers: [String]
    let questionType: String
    let questionText: String
    let questionSubtext: String
    let instructionText: String
    let questionNumber: Int
//    enum CodingKeys: String, CodingKey {
//      case ID
//      case QuestionID
//      case IsSingleChoice
//
//  //  let name: String
//    }
}
