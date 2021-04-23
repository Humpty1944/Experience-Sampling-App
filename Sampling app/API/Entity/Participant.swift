//
//  Participant.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation

struct Participant: Codable {
    let id: Int
    let projectID: Int?
    let participantStatus: String
    //let ParticipantStatusID: Int
    let timeNotificationStart: Time//Date
    let dateStart: String?
    let dateEnd: String?
    let timeNotificationEnd: Time//Date
    let notificationCountPerDay: Int
    let notificationMinValueVariation: Int
    let token: String
    let nickname: String
    let email: String
    let phoneNumber: String
    
//    enum CodingKeys: String, CodingKey {
//        case ID
//        case ProjectID
//        case ParticipantStatusID
//        case TimeNotificationStart
//        case TimeNotificationEnd
//        case  NotificationCountPerDay
//        case NotificationMinValueVariation
//    }
}
struct Time: Codable{
    let ticks: Float
    let days: Float
    let hours: Float
    let milliseconds: Float
    let minutes: Float
    let seconds: Float
    let totalDays: Float
    let totalHours: Float
    let totalMilliseconds: Float
    let totalMinutes: Float
    let totalSeconds: Float
    
}

extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}
