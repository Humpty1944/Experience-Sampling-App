//
//  UserNotification.swift
//  Sampling app
//
//  Created by Назарова on 02.03.2021.
//

import Foundation
import UserNotifications
import UIKit
import CoreData

//struct LocalNotification {
//    var id: String
//    var title: String
//    var body: String
//    var time: DateComponents
//}
enum ErrorDubl: Error {
    case some
   
}

//enum LocalNotificationDurationType {
//    case days
//    case hours
//    case minutes
//    case seconds
//}

struct UserNotification {
    
//    static private var notifications = [LocalNotification]()
    static private var timeInterval = Date()
    static private var from = Date()
    static private var to = Date()
    static private var quantity:Int = 1
    static private var begin = Date()
    static private var min_interval: Int = 10
    
  
    static private func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    // We have permission!
                }
        }
    }
   static func deleteAllData(_ entity:String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext =  appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false

        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
   }

    static func fetchNotif(date_curr: Date)->[NSManagedObject]
    {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return [NSManagedObject]()
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Notifications")
        //let curr = UserDefaults.standard.integer(forKey: "currIndex")
       // print(curr)
       // print(UserDefaults.standard.integer(forKey: "curr_val"))
        //fetchRequest.predicate = NSPredicate(format: "date == %@", date_curr as CVarArg)
        //fetchRequest.resultType = .dictionaryResultType
          //3
        var date: [NSManagedObject] = [NSManagedObject]()
          do {
            date = try managedContext.fetch(fetchRequest)
            
            for d in date{
                print("qqqqqq", d.value(forKeyPath: "date") , d.value(forKeyPath: "id_count"))
            }
            
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        return date
        //[curr]
    }
    
    static func find (data: [NSManagedObject], date: Date )throws ->NSManagedObject{
        var isFind = false
        for d in data{
            let cur = d.value(forKeyPath: "date") as! Date
            let day_cur = Calendar.current.component(.day, from: cur)
            let month_cur = Calendar.current.component(.month, from: cur)
            let hour_cur = Calendar.current.component(.hour, from: cur)
            let min_cur = Calendar.current.component(.minute, from: cur)
            let hour_d = Calendar.current.component(.hour, from: date)
            let min_d = Calendar.current.component(.minute, from: date)
            let day_d = Calendar.current.component(.day, from: date)
            let month_d = Calendar.current.component(.month, from: date)
           
            let diff = cur.minutes(from: Date())
            print("currrrrr", cur, date, diff)
            if hour_cur==hour_d && min_cur==min_d && month_cur==month_d && day_cur==day_d {
                isFind = true
                return d
            }
            if diff<0 && abs(diff)>20{
                UserNotification.delete(data: data, date: d)
            }
        }
        
        if isFind==false{
            throw ErrorDubl.some
        }
        return NSManagedObject()
        
    }
    
    static func findNearest(data: [NSManagedObject]) throws-> NSManagedObject{
        var nearest = NSManagedObject()
        var isFind = false
       // nearest.setValue(99999, forKeyPath: "id_count")
        //nearest.setValue(Date(), forKey: "date")
        var min = 10000000000
        for d in data{
            let cur = d.value(forKeyPath: "date") as! Date
        
            let diff = cur.minutes(from: Date())
            print("nearest", cur, diff)
//            let hour_d = Calendar.current.component(.hour, from: date)
//            let min_d = Calendar.current.component(.minute, from: date)
//            let day_d = Calendar.current.component(.day, from: date)
//            let month_d = Calendar.current.component(.month, from: date)
            //print("currrrrr", cur, Date(), diff)
            if diff<=0 && abs(diff)<min {
                min = abs(diff)
                nearest = d
                isFind = true
            }
            if diff<0 && abs(diff)>20{
                UserNotification.delete(data: data, date: d)
            }
        }
        if isFind==false{
            throw ErrorDubl.some
        }
        return nearest
    }
    
    static func deleteNearest(data: [NSManagedObject],date: NSManagedObject ){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Notifications")
       
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                let date_m = managedObjectData.value(forKey: "date") as! Date
                let date_d = date.value(forKey: "date") as! Date
                if date_m==date_d{
                managedContext.delete(managedObjectData)
                }
            }
            let results_new = try managedContext.fetch(fetchRequest)
            for d in results_new{
               // print("newnewnewnewn", d.value(forKeyPath: "date") , d.value(forKeyPath: "id_count"))
            }
        } catch let error as NSError {
            //print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
        //managedContext.delete(date)
    }
    
    static func delete(data: [NSManagedObject],date: NSManagedObject ){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Notifications")
       
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                let date_m = managedObjectData.value(forKey: "date") as! Date
                let date_d = date.value(forKey: "date") as! Date
                if date_m==date_d{
                managedContext.delete(managedObjectData)
                }
            }
            let results_new = try managedContext.fetch(fetchRequest)
            for d in results_new{
               // print("newnewnewnewn", d.value(forKeyPath: "date") , d.value(forKeyPath: "id_count"))
            }
            var entries = UserDefaults.standard.string(forKey: "entries")!
            entries+="F "
            //print(entries)
           
            UserDefaults.standard.setValue(entries, forKey: "entries")
        } catch let _ as NSError {
            //print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
        //managedContext.delete(date)
    }
    
//    static func notificationLost(){
//        
//    }
    
    static private func addNotification() -> Void {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
          NSEntityDescription.entity(forEntityName: "Notifications",
                                     in: managedContext)!
        let date = createNewTime()
//        let not = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
        
        // 3
        //print(date)
        for i in 0..<date.count{
            let not = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
            not.setValue(i, forKeyPath: "id_count")
            not.setValue(date[i], forKey: "date")
            managedContext.insert(not)
        }
        print("New_curr", Date())
//        var dayComponent    = DateComponents()
//        dayComponent.minute    = 1 // For removing one day (yesterday): -1
//        let theCalendar     = Calendar.current
//        let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())
//        print("New ", nextDate)
//        UserNotification.createNotification(date: nextDate!)
//        let not = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
//        not.setValue(15, forKeyPath: "id_count")
//        not.setValue(nextDate, forKey: "date")
//        managedContext.insert(not)
//         dayComponent    = DateComponents()
//        dayComponent.minute    = 2 // For removing one day (yesterday): -1
//        let theCalendar_n     = Calendar.current
//        let nextDate_n       = theCalendar.date(byAdding: dayComponent, to: Date())
//        print("New ", nextDate_n)
//        UserNotification.createNotification(date: nextDate_n!)
//        let not_n = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
//        not_n.setValue(25, forKeyPath: "id_count")
//        not_n.setValue(nextDate_n, forKey: "date")
//        managedContext.insert(not_n)
//        UserNotification.createNotification(date: nextDate_n!)
        do {
            try managedContext.save()
            //print("aa")
          //people.append(person)
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
       // notifications.append(LocalNotification(id: UUID().uuidString, title: title, body: body, time: setTime()))
    }
    
    static func createNewTime()->[Date]{
        
        var date: [Date] = [Date]()
        let calendar = Calendar.current
       // let from_new=calendar.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
       // print("from", from_new)
        //self.from = from_new
        //self.to=calendar.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!
        //let isoDate = "2016-04-14T10:44:00+0000"

        let dateFormatter = DateFormatter()
       // dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
       // dateFormatter.locale = Locale.current
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
       // dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        print(UserDefaults.standard.string(forKey: "dateStart"))
        let dateStart = UserDefaults.standard.string(forKey: "dateStart") ?? "2021-04-25T02:53:316"
        //let date_new = dateFormatter.date(/*from:UserDefaults.standard.string(forKey: "dateStart") ??*/ from: "2017-03-26T02:53:316" )
        let date_end_new = UserDefaults.standard.string(forKey: "dateStart") ?? "2021-04-29'T'16:23:42"
        //let calendar = Calendar.current
       // let components = calendar.dateComponents([.year, .month, .day, .hour], from: date_new!)
       // let components_end = calendar.dateComponents([.year, .month, .day, .hour], from: date_end_new!)
       // let finalDate = calendar.date(from:components)
        calendar.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
        let max_interval = calcMaxInterval()
        var days = String(dateStart[8...9])
        let day_begin = Int(days)!
//        let day = Int(days)!
//        var begin_day = calendar.date(bySetting: .day, value: day, of: Date())
//        let begin_day_fin = calendar.date(bySetting: .month, value: Int(dateStart[5...6])!, of: begin_day!)//calendar.date(from:components)// UserDefaults.standard.object(forKey: "dateStart") as! Date
        
        var days_ned = String(date_end_new[8...9])
        let day_ned = Int(days_ned)!
        let day_end = (date_end_new[5...6])
//        var end_day = calendar.date(bySetting: .day, value: day_ned, of: Date())
//        let end_day_fin = calendar.date(bySetting: .month, value: Int(date_end_new[5...6])!, of: end_day!)!
        
        
        //let end_day =  calendar.date(from:components_end)!//UserDefaults.standard.object(forKey: "dateEnd") as! Date
        let diff = abs(day_ned-day_begin)
        let countPerDay =  UserDefaults.standard.integer(forKey: "notificationCountPerDay")
        for i in 0..<diff{
            var dateComponents = DateComponents()
                 dateComponents.day = i
            let help = Date()
            let d = Calendar.current.date(bySettingHour: calendar.component(.hour, from: from), minute: calendar.component(.minute, from: from), second: 0, of: Date())!
           var curr = calendar.date(byAdding: dateComponents, to: d)!
           // print("begin", curr)
            for j in 0..<countPerDay{
                let generate = Int.random(in: min_interval...max_interval*60)
               // print("generte", generate)
                let hoursAndMin = fromMinToHours(min: generate)
               // print("hours", hoursAndMin)
                var new_time = calendar.date(byAdding: .hour, value: hoursAndMin[0], to: curr)
                curr = new_time!
                new_time = calendar.date(byAdding: .minute, value: hoursAndMin[1], to: curr)
                print("New", new_time)
                
                if i==0 && j==0{
                    UserDefaults.standard.setValue(new_time, forKey: "CurrTimeForNotif")
                }
                createNotification(date: new_time!)
                curr=new_time!
                date.append(curr)
            //print(curr)
            }
        }
        
        
        return date
    }
    static func calcMaxInterval()->Int{
        var calendar = Calendar.current
        let min_hours = calendar.component(.hour, from: from)
       // print("min", min_hours)
        let max_hours = calendar.component(.hour, from: to)
       // print("max", max_hours)
       // print("dif", (max_hours-min_hours)/3)
        return (max_hours-min_hours)/3
    }
    static func fromMinToHours(min: Int)->[Int]{
        var timeNew:[Int] = [Int]()
               if min>=60{
                   timeNew.append((min - min % 60) / 60)
               }
               else{
                   timeNew.append(0)
               }
               timeNew.append(min - timeNew[0] * 60)
               return timeNew
    }
    static func createNotification(date:Date){
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "notification.mp3"))
        notificationContent.title = "Experience sampling "
        notificationContent.body = "Время заполнить дневник!"
        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)

        // Add Trigger
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)//UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "HH:mm E, d MMM y"
      //  print(formatter1.string(from: today))
        // Create Notification Reqdauest
        let notificationRequest = UNNotificationRequest(identifier: "local_notification"+formatter1.string(from: date), content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    


    
    static func cancel() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    static func setNotification(_ /*duration: Int, of type: LocalNotificationDurationType, repeats: Bool,*//* userInfo: [AnyHashable : Any],*/ from:Date, to:Date, quantity: Int, interval: Int) {
        
        UserDefaults.standard.setValue(0, forKey: "currIndex")
        UserDefaults.standard.setValue(false,forKey: "BeginNotif")
        //var calendar = Calendar.current
      // var max_interval = calcMaxInterval()
        //var begin_day = calendar.date(bySettingHour: calendar.component(.hour, from: from), minute: calendar.component(.minute, from: from), second: 0, of: begin)!
        self.from=from//calendar.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
        self.to=to//calendar.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!
        self.min_interval = interval
       // self.timeInterval=60//durantion
        requestPermission()
       // for i in 0..<quantity{
            addNotification()
        //}
        //addNotification(title: title, body: body)
       // scheduleNotifications(/*duration, of: type, repeats: repeats,*/ userInfo)
    }

}

extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}

