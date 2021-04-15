//
//  SliderQuestion.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation

import UIKit

struct SliderQuestion: Codable {
    let ID: Int
    let QuestionID: Int?
    let SliderMinValue: Int
    let SliderMaxValue:Int
    let IsDiscrete: Bool
    let LeftText: String
    let RightString: String
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
    case SliderMinValue
    case SliderMaxValue
    case IsDiscrete
    case LeftText
    case RightString
//  let name: String
  }
}

//struct Location: Codable {
//  let displayAddress: [String]
//
//  enum CodingKeys: String, CodingKey {
//    case displayAddress = "display_address"
//  }
//}
