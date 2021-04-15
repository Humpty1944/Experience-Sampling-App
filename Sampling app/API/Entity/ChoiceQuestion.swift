//
//  ChoiceQuestion.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation
struct ChoiceQuestion:Codable{
    let ID: Int
    let QuestionID:Int?
    let IsSingleChoice:Bool
    
    enum CodingKeys: String, CodingKey {
      case ID
      case QuestionID
      case IsSingleChoice
     
  //  let name: String
    }
}
