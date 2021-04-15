//
//  Question.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation
struct Question: Codable {
    let ID: Int
    let ProjectID:Int?
    let QuestionTypeID:Int
    let QuestionText: String
    let QuestionSubtext: String
    let InstructionText: String
    let QuestionNumber: Int
    
    enum CodingKeys: String, CodingKey {
      case ID
      case ProjectID
      case QuestionTypeID
      case QuestionText
      case QuestionSubtext
      case InstructionText
      case QuestionNumber
  //  let name: String
    }
    
  }
