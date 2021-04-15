//
//  DiscreteSliderQuestion.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation

struct DsicreteSliderQuestion: Codable {
    let ID: Int
    let QuestionID: Int?
    let DiscreteSliderMinValue: Int
    let DiscreteSliderMaxValue:Int
    let ScaleText: String

//  let name: String
//  let imageUrl: String
//  let rating: CGFloat
//  let reviewCount: Int
//  let price: String
//  let displayPhone: String
//  let photos: [String]
//  let location: Location

  enum CodingKeys: String, CodingKey {
    case ID
    case QuestionID
    case DiscreteSliderMinValue
    case DiscreteSliderMaxValue
    case ScaleText
//  let name: String
  }
}
