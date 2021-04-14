//
//  HelpFunctions.swift
//  Sampling app
//
//  Created by Назарова on 12.04.2021.
//

import Foundation
import UIKit

class HelpFunction: NSObject{
    static var questions:  [Int] = [Int]()
    static var pos: Int = -1
    static var isReturn: Bool  = false
    static var questDict: [Int: Int] = [:]
    static var dictInd: [Int: [Int]] = [Int: [Int]]()
    static var isTest: Bool = false
    
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
       print(UserDefaults.standard.dictionaryRepresentation())
        var count=0
        for d in dictInd{
           print("dddddd", d.value.count)
            count+=d.value.count
        }
      print(count)
        if count<16{
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
        print(allData)
        for data in allData.keys{
            let val = userDefault.string(forKey: data)
          
            if val == "" || val == "-9999" || val == "{-1000, -1000}"{
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
        
        let defaults = UserDefaults.standard
            let dictionary = defaults.dictionaryRepresentation()
        print(dictionary)
            dictionary.keys.forEach { key in
                defaults.removeObject(forKey: key)
            }
        if code != nil{
            defaults.setValue(code, forKey: "code")
        }
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
    }
    

