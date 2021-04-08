//
//  UserNotification.swift
//  Sampling app
//
//  Created by Назарова on 02.03.2021.
//

import Foundation
import UserNotifications
import UIKit

struct LocalNotification {
    var id: String
    var title: String
    var body: String
    var time: DateComponents
}

enum LocalNotificationDurationType {
    case days
    case hours
    case minutes
    case seconds
}

struct UserNotification {
    
    static private var notifications = [LocalNotification]()
    static private var timeInterval=DateComponents()
    static private var from = DateComponents()
    static private var to = DateComponents()
    static private var quantity:Int = 1
    
    static private func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    // We have permission!
                }
        }
    }
    
    static private func addNotification(title: String, body: String) -> Void {
        notifications.append(LocalNotification(id: UUID().uuidString, title: title, body: body, time: setTime()))
    }
    static private func setTime()->DateComponents{
        var dateInfo = DateComponents()
        let currnetDate = Calendar.current
        let date = Date()
        let components = currnetDate.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateInfo.day = components.day
        dateInfo.month = components.month
        dateInfo.year = components.year
        if notifications.count==0{
            dateInfo.hour = Int.random(in: from.hour!...from.hour!+timeInterval.hour!)
            dateInfo.minute = Int.random(in: from.minute!...from.minute!+timeInterval.minute!)
        }
        else if notifications.count==quantity-1{
            dateInfo.hour = Int.random(in: notifications[notifications.count-1].time.hour!+timeInterval.hour!...to.hour!)
            dateInfo.minute = Int.random(in: notifications[notifications.count-1].time.minute!+timeInterval.minute!...to.minute!)
        }
        else {
            dateInfo.hour = Int.random(in: notifications[notifications.count-1].time.hour!+timeInterval.hour!...notifications[0].time.hour!+timeInterval.hour!)
            dateInfo.minute = Int.random(in: notifications[notifications.count-1].time.minute!+timeInterval.minute!...notifications[0].time.minute!+timeInterval.minute!+15)
        }
        return dateInfo
    }
    
    static private func scheduleNotifications(_ /*durationInSeconds: Int, repeats: Bool,*/ userInfo: [AnyHashable : Any]) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = UNNotificationSound.default
            content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
            content.userInfo = userInfo
            ///___________________________________________________
//            let currnetDate = Calendar.current
           var dateInfo = DateComponents()
//            let date = Date()
//            let components = currnetDate.dateComponents([.year, .month, .day, .hour, .minute], from: date)
//            var time = mintransform(time: durantion)
//            dateInfo.day = components.day //Put your day
//            dateInfo.month = components.month //Put your month
//            dateInfo.year = components.year // Put your year
//            if(count==0){
//                dateInfo.hour = Int.random(in: from...from+time[0])
//                dateInfo.minute = Int.random(in: from...from+time[1])
//            }
//            else if (count==notifications.count-1){
//                dateInfo.hour = Int.random(in: notifications[i-1].)
//                dateInfo.minute = Int.random(in: from...from+time[1])
//            }
//            dateInfo.hour = 8 //Put your hour
//            dateInfo.minute = 0 //Put your minutes
            
            ///___________________________________________________
            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.time, repeats: false)
            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(durationInSeconds), repeats: repeats)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.id)")
            }
        }
        notifications.removeAll()
    }
//    static private func mintransform(time:Int)->[Int]{
//        var timeNew:[Int] = [Int]()
//        if time>=60{
//            timeNew.append((time - time % 60) / 60)
//        }
//        else{
//            timeNew.append(0)
//        }
//        timeNew.append(time - timeNew[0] * 60)
//        return timeNew
//    }
    
//    static private func scheduleNotifications(_ /*duration: Int, of type: LocalNotificationDurationType, repeats: Bool,*/ userInfo: [AnyHashable : Any], from:Int, to:Int, quantity: Int) {
////        var seconds = 0
////        switch type {
////        case .seconds:
////            seconds = duration
////        case .minutes:
////            seconds = duration * 60
////        case .hours:
////            seconds = duration * 60 * 60
////        case .days:
////            seconds = duration * 60 * 60 * 24
////        }
//       // scheduleNotifications(/*seconds, repeats: repeats,*/ userInfo: userInfo)
//    }
    
    static func cancel() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    static func setNotification(_ /*duration: Int, of type: LocalNotificationDurationType, repeats: Bool,*/ title: String, body: String, userInfo: [AnyHashable : Any], from:DateComponents, to:DateComponents, quantity: Int, durantion: DateComponents) {
        self.from=from
        self.to=to
        self.timeInterval=durantion
        requestPermission()
        for _ in 1...quantity{
            addNotification(title: title, body: body)
        }
        //addNotification(title: title, body: body)
        scheduleNotifications(/*duration, of: type, repeats: repeats,*/ userInfo)
    }

}

