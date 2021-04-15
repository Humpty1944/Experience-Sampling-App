//
//  ParticipantAnswer.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation

class ParticipantAnswer: Decodable
{
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ID = try container.decode(Int.self, forKey: .ID)
        self.QuestionID = try container.decode(Int.self, forKey: .QuestionID)
        self.ProjectID = try container.decode(Int.self, forKey: .ProjectID)
        self.AnswerText = try container.decode(String.self, forKey: .AnswerText)
        self.AnswerDate = try container.decode(Date.self, forKey: .AnswerDate)
    }

    var ID: Int?

    var QuestionID: Int?
    var ProjectID: Int?
    var AnswerText: String
    var AnswerDate: Date

    private enum CodingKeys: String, CodingKey{
        case ID, QuestionID, ProjectID, AnswerText, AnswerDate
    }
}
