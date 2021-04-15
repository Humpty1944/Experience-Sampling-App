//
//  Participant.swift
//  Sampling app
//
//  Created by Назарова on 15.04.2021.
//

import Foundation

struct Participant {
    let ID: Int
    let ProjectID: Int?
    let ParticipantStatusID: Int
    let TimeNotificationStart: Date
    let TimeNotificationEnd: Date
    let  NotificationCountPerDay: Int
    let NotificationMinValueVariation: Int
    
    enum CodingKeys: String, CodingKey {
        case ID
        case ProjectID
        case ParticipantStatusID
        case TimeNotificationStart
        case TimeNotificationEnd
        case  NotificationCountPerDay
        case NotificationMinValueVariation
    }
}
