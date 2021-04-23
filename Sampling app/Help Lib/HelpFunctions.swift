//
//  HelpFunctions.swift
//  Sampling app
//
//  Created by Назарова on 12.04.2021.
//

import Foundation
import UIKit

class HelpFunction:NSObject, URLSessionDelegate{
   
    
   // var description: String
    
    static var questions:  [Int] = [Int]()
    static var pos: Int = -1
    static var isReturn: Bool  = false
    static var questDict: [Int: Int] = [:]
    static var dictInd: [Int: [Int]] = [Int: [Int]]()
    static var isTest: Bool = false
    static var questionsLook: [AnyObject] = [AnyObject]()
    static var questionArr: [[String: Any]] = [[String: Any]]()
     var requestTask: URLSessionDataTask?
    var wait :Bool = true
    static func setQuestionArr(arr: [[String: Any]]){
        questionArr=arr
    }
    
    static func setQuestionsLook(arr:[AnyObject]){
        questionsLook=arr
    }
    static func isTestSet(val:Bool){
        isTest = val
    }
    static func addDict(position:Int, index: Int){
      
        if questDict[position]==nil{
            questDict[position]=0
            dictInd[position]=[index]
           

        }
        else if dictInd[position]?.contains(index) == false {
            questDict[position]!+=1
            dictInd[position]!.append(index)
        }
        //print(dictInd)
    }
    
//    static func removeFromDict(position:Int, index: Int){
//        let farray = dictInd[position]!.filter {$0 != index}
//        dictInd[position] = farray
//        if dictInd[position]!.count <= 0{
//            questDict[position]!=0
//        }
//    }
    static func setPos(val:Int){
        pos=val
    }
    static func checkReceiveAllAnswers()->Bool{
       print("print(",UserDefaults.standard.dictionaryRepresentation())
        var count=0
        for d in dictInd{
           
            count+=d.value.count
        }
      //print(count)
        if count<questionArr.count{
            return false
        }
        return true

    }
    static func setReturn(val: Bool){
        isReturn = val
    }
    static func getForgetQuestions(){
        questions = [Int]()
        let userDefault = UserDefaults.standard
        var allData = userDefault.dictionaryRepresentation()
        print("data to server",allData)
        for data in allData.keys{
            let val = userDefault.string(forKey: data)
          
            if val == "" || val == "-9999" || val == "{-1000, -1000}" || val == "-1"{
               // print (data)
                if data.contains("_"){
                    let separated = (data as String).split(separator: "_")
                   
                                   if let some = separated.first {
                                       let value = String(some)
                                       let return_val:Int = Int(value) ?? -10
                                       if return_val != -10{
                                           questions.append(return_val)
                                       }
                }
            }
            }
        }
        
        questions =  Array(Set(questions))
        questions.sort()
        
    }
//            if data.value as! NSObject == nil{
//                if data.key.contains("_"){
//                let separated = (data.key as AnyObject).characters.split(separator: "_")
//
//                if let some = separated.first {
//                    let value = String(some)
//                    let return_val:Int = Int(value) ?? -1
//                    if return_val != -1{
//                        questions.append(return_val)
//                    }
//                }
//                }
//                }
                
      //      }
    //}
    
    static func getNextForgetQuestionNumber()->Int{
        if questions.isEmpty == true{
            return -1
        }
        let c:Int =  questions[pos]
        pos+=1
        return c
         }
    
    static func getPrevForgetQuestionNumber()->Int{
        pos-=1
        return questions[pos]
    }
    
    static func deleteAll(){
        let code = UserDefaults.standard.object(forKey: "code")
        let isFirst = UserDefaults.standard.bool(forKey: "IsFirst")
        print("isfirst", isFirst)
        let beginNotif = UserDefaults.standard.bool( forKey: "BeginNotif")
        let all =  UserDefaults.standard.integer(forKey: "All")
        let entries = UserDefaults.standard.string(forKey: "entries")
        let curr = UserDefaults.standard.integer(forKey: "currIndex")
        let curr_time =  UserDefaults.standard.object(forKey: "CurrTimeForNotif")
        let count = UserDefaults.standard.integer(forKey: "countQuestion")
        let valDay = UserDefaults.standard.string(forKey: "dayCurr")
//        let beginDay = UserDefaults.standard.object(forKey: "beginDay")
//        let endDay = UserDefaults.standard.object(forKey: "endDay")
        let nickname = UserDefaults.standard.string( forKey: "nickname")
        let email =  UserDefaults.standard.string(forKey: "email")
        let notificationCountPerDay = UserDefaults.standard.string(forKey: "notificationCountPerDay")
        let notificationMinValueVariation = UserDefaults.standard.integer(forKey: "notificationMinValueVariation")
        let timeNotificationEnd_hours =  UserDefaults.standard.object(forKey: "timeNotificationEnd.hours")
        let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")
        let timeNotificationEnd_minutes = UserDefaults.standard.string(forKey: "timeNotificationEnd.minutes")
        
        let timeNotificationStart_hours =  UserDefaults.standard.object(forKey: "timeNotificationStart.hours")
        let projectID = UserDefaults.standard.integer(forKey: "projectID")
        let timeNotificationStart_minutes = UserDefaults.standard.string(forKey: "timeNotificationStart.minutes")
        let idPart = UserDefaults.standard.integer( forKey: "idPart")
        let defaults = UserDefaults.standard
            let dictionary = defaults.dictionaryRepresentation()
        //print(dictionary)
            dictionary.keys.forEach { key in
                defaults.removeObject(forKey: key)
            }
       // if code != nil{
            defaults.setValue(code, forKey: "code")
            defaults.setValue(isFirst, forKey: "IsFirst")
            defaults.setValue(beginNotif, forKey: "BeginNotif")
            defaults.setValue(all, forKey: "All")
            defaults.setValue(entries, forKey: "entries")
            defaults.setValue(curr, forKey: "currIndex")
            defaults.setValue(curr_time, forKey: "CurrTimeForNotif")
            defaults.setValue(count, forKey: "countQuestion")
            defaults.setValue(valDay, forKey: "dayCurr")
           // defaults.setValue(beginDay, forKey: "beginDay")
            //defaults.setValue(endDay, forKey: "endDay")
        defaults.setValue(nickname, forKey: "nickname")
        defaults.setValue(email, forKey: "email")
        defaults.setValue(notificationCountPerDay, forKey: "notificationCountPerDay")
        defaults.setValue(notificationMinValueVariation, forKey: "notificationMinValueVariation")
        defaults.setValue(phoneNumber, forKey: "phoneNumber")
        defaults.setValue(timeNotificationEnd_hours, forKey: "timeNotificationEnd.hours")
        defaults.setValue(timeNotificationEnd_minutes, forKey: "timeNotificationEnd.minutes")
        defaults.setValue(timeNotificationStart_minutes, forKey: "timeNotificationStart.minutes")
        defaults.setValue(timeNotificationStart_hours, forKey: "timeNotificationStart.hours")
        //defaults.setValue(code, forKey: "code")
        defaults.setValue(projectID, forKey: "projectID")
        defaults.setValue(idPart, forKey: "idPart")
           // defaults.setValue(code, forKey: "code")
           // defaults.setValue(code, forKey: "code")
            
       // }
        questDict = [:]
       dictInd = [Int: [Int]]()
        HelpFunction.isReturn = false
        HelpFunction.pos = -1
    }
    
    static func normalizePoint(point:CGPoint, max_x: CGFloat, max_y: CGFloat, min_x: CGFloat, min_y: CGFloat, max_x_send: CGFloat, max_y_send:CGFloat, min_x_send: CGFloat, min_y_send:CGFloat)->String{
        let x: CGFloat = (point.x-min_x)/(max_x-min_x)*(max_x_send-min_x_send)+min_x_send
        let y: CGFloat = (point.y-min_y)/(max_y-min_y)*(max_y_send-min_y_send)+min_y_send
        let s = "(\(x.description);\(y.description))"
       
        return s
    }
     func sendDefault(){
        var code = UserDefaults.standard.string(forKey:"code")!
        let new_url = code.stringByAddingPercentEncodingForRFC3986()!
        var location = "https://45.67.230.70:5001/api/Participant/SendQuestion?token="+new_url
        let json: [String: Any] = [
                                   "isAnswered": false,
                                   "participantID": UserDefaults.standard.integer(forKey: "idPart"),
                                   "questionId": 0,
                                    "answerText": "answer",
                                    "answerdDate" : Date()]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let requestURL = URL(string: location)
        var request = URLRequest(url: requestURL!)

        request.httpMethod = "POST"
        request.httpBody = jsonData
        requestTask = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil).dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if(error != nil) {
                print("Error: \(error)")
            }else
            {do{
                let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        print(responseJSON)
                    }
                //completionBlock(outputStr!);
            }catch{
                print("nooo")
            }
        
        
    }
        }
        requestTask?.resume()
    }
    static func formURL()-> String{
        var code = UserDefaults.standard.string(forKey:"code")!
        let new_url = code.stringByAddingPercentEncodingForRFC3986()!
        //print("firs ", encoded)
        //code = code.addingPercentEncoding(withAllowedCharacters: .)!
        //print("secind" ,code)
        var location = "https://45.67.230.70:5001/api/Participant/SendAnswer?token="+new_url
        return location
    }
    
    func sendData(data_send: [String: Any], answer:String){
       
        let formatter3 = DateFormatter()
        formatter3.dateFormat  = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let ssend = formatter3.string(from: Date())
        print(ssend)
        let json: [String: Any] = [
                                   "isAnswered": true,
                                   "participantID": UserDefaults.standard.integer(forKey: "idPart"),
                                   "questionId": data_send["id"] as! Int,
                                    "answerText": answer,
                                    "answerdDate" : "2021-04-22T19:07:01.963Z"]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
       // let requestURL = URL(string: location)
        //var request = URLRequest(url: requestURL!)
        var code = UserDefaults.standard.string(forKey:"code")!
        let encoded = code.stringByAddingPercentEncodingForRFC3986()
        print("firs ", encoded)
        //code = code.addingPercentEncoding(withAllowedCharacters: .)!
        print("secind" ,code)
        var location = "https://psycho.sudox.ru/api/Participant/SendAnswer?token="+encoded!
        print("dfsdfdf", location)
        var url : NSString = (location) as NSString
       // let str = String(describing: url.cString(using: String.Encoding.utf8))
        var urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        var searchURL : NSURL = NSURL(string: urlStr as String)!
        //let headers: HTTPHeaders = [.authorization(bearerToken: code)]
        var request = URLRequest(url: searchURL as URL)
        request.httpMethod = "POST"
        var postString = "isAnswered=true&participantID="+UserDefaults.standard.string(forKey: "idPart")!
        print(data_send["id"])
        postString+="&questionId="+String(data_send["id"] as! Int)
        postString+="&answerText="+answer
        postString+="&answerdDate="+ssend
        request.httpBody = jsonData
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
       //[request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"]
        requestTask = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil).dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            // Check for Error
                   if let error = error {
                       print("Error took place \(error)")
                       return
                   }
            
                   // Convert HTTP Response Data to a String
                   if let data = data, let dataString = String(data: data, encoding: .utf8) {
                       print("Response data string:\n \(dataString)")
                    self.wait=false
                   }
    
        }
        requestTask?.resume()
    }
             
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
           //Trust the certificate even if not valid
           let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)

           completionHandler(.useCredential, urlCredential)
        }
    }
    
    

    

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}
