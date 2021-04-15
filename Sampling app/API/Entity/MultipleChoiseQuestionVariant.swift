//
//  MultipleChoiseQuestionVariant.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation

struct MultipleChoiseQuestionVariant {
    let ID: Int
    let  QuestionID:Int?
    let  AnswerText: String
    
    enum CodingKeys: String, CodingKey {
      case ID
      case QuestionID
      case AnswerText
     
  //  let name: String
    }
}
