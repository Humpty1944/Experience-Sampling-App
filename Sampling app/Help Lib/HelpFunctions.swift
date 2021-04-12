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
    static func addDict(position:Int, index: Int){
        print(position, index)
        print(questDict[position]==nil)
        if questDict[position]==nil{
            questDict[position]=0
            dictInd[position]=[index]
           

        }
        else if dictInd[position]?.contains(index) == false {
            questDict[position]!+=1
            dictInd[position]!.append(index)
        }
        print(dictInd)
    }
    static func setPos(val:Int){
        pos=0
    }
    static func checkReceiveAllAnswers()->Bool{
        let userDefault = UserDefaults.standard
        var count=0
        for d in dictInd{
            print(d.value)
            count+=d.value.count
        }
        print(count)
        if count<16{
            return false
        }
        return true
//        var count=0
//        var allData = userDefault.dictionaryRepresentation()
//
//        for data in allData.keys{
//            let val = userDefault.string(forKey: data)
//            print (val)
//            if val == "" || val == "-9999" || val == "{-1000, -1000}"{
//
//                if data.contains("_"){
//
//                    let separated = (data as String).split(separator: "_")
//                    //print (separated.first)
//                                   if let some = separated.first {
//                                       let value = String(some)
//                                    print("vv", value)
//                                       let return_val:Int = Int(value) ?? -10
//                                       if return_val != -10{
//                                           count+=1
//                                       }
//                                    print("-",count)
//                }
//            }
//            }
//        }
//
//        if HelpFunction.isReturn != true{
//            return false
//        }
//        return true
    }
    static func setReturn(val: Bool){
        isReturn = val
    }
    static func getForgetQuestions(){
        questions = [Int]()
        let userDefault = UserDefaults.standard
        var allData = userDefault.dictionaryRepresentation()
        
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
            dictionary.keys.forEach { key in
                defaults.removeObject(forKey: key)
            }
        if code != nil{
            defaults.setValue(code, forKey: "code")
        }
    }
    }
    

