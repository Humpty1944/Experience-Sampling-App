//
//  ViewAllCorrect.swift
//  Sampling app
//
//  Created by Назарова on 11.04.2021.
//

import Foundation
import UIKit
class ViewAllCorrect: UIViewController{
    
    
    @IBOutlet weak var buttonRepaetSend: CustomButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        buttonRepaetSend.isHidden=true
        buttonRepaetSend.isEnabled = false
        if HelpFunction.isTest == true{
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
                HelpFunction.deleteAll()
                HelpFunction.isTest=false
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
               
                self.navigationController?.pushViewController(viewController, animated: true)
                
                    }
            
        }else{
        
        let curr_notif = UserDefaults.standard.object(forKey: "CurrTimeForNotif") as! Date
        print("curr",curr_notif)

        let minutes = curr_notif.minutes(from: Date())

        //let diffs = Calendar.current.dateComponents([.year, .month, .day], from: date1, to: date2)
        UserDefaults.standard.setValue(false, forKey: "BeginNotif")
        //let currIndex = UserDefaults.standard.object(forKey: "currIndex")as! Int
        var entries = UserDefaults.standard.string(forKey: "entries") as! String
        //UserDefaults.standard.setValue(currIndex+1, forKey: "currIndex")
            var help = HelpFunction()
        if abs(minutes)<=20 {
            send()
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
            HelpFunction.deleteAll()
            
            entries+="T "
           
            UserDefaults.standard.setValue(entries, forKey: "entries")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
           
            self.navigationController?.pushViewController(viewController, animated: true)
            
                }
        }
        else{
            entries+="F "
            UserDefaults.standard.setValue(entries, forKey: "entries")
            help.sendDefault()
        }
        }
    }
    
    func repeateSend(){
        buttonRepaetSend.isHidden=false
        buttonRepaetSend.isEnabled = true
    }
    
    @IBAction func sendAgain(_ sender: Any) {
        
        send()
    }
    
    func send(){
        HelpFunction.questionArr.sort { ($0["questionNumber"] as! Int) < ($1["questionNumber"] as! Int) }
        var i = 1
        var j = 1
        var Help = HelpFunction()
        for q in  HelpFunction.questionArr{
            let curr_answer = UserDefaults.standard.object(forKey: String(i)+"_"+"0")
            if (q["questionType"] as! String) == "AffectGrid"{
               // let location = UserDefault.standard.string(forKey: String(questionNumber)+"_"+"0")
                
                var fin_loc = NSCoder.cgPoint(for: curr_answer as! String)
                let send = HelpFunction.normalizePoint(point: fin_loc, max_x: CGFloat(360), max_y: CGFloat(360), min_x: CGFloat(0), min_y: CGFloat(0), max_x_send: q["maxX"] as! CGFloat, max_y_send: q["maxY"]  as! CGFloat, min_x_send: q["minX"] as! CGFloat, min_y_send: q["minY"]  as! CGFloat)
                
                Help.sendData(data_send: q, answer: send)
//                while Help.wait==false{
//                    print("ssss")
//                }
//                Help.wait=false
                //HelpFunction.sendData(<#T##self: HelpFunction##HelpFunction#>)
            }
            else{
               // print(curr_answer )
               
                
                if (q["questionType"] as! String) == "DiscreteSlider"{
                   var  ans=String(curr_answer as! Int) + "#"
                    while var answer = UserDefaults.standard.object(forKey: String(i)+"_"+String(j)){
                        ans+=String(UserDefaults.standard.integer(forKey: String(i)+"_"+String(j)))+"#"
                        j+=1
                    }
                    
                    
                    
                    Help.sendData(data_send: q, answer: ans)
                }
                    else{
                Help.sendData(data_send: q, answer: String(curr_answer as! Float))
                    }
//                while Help.wait==false{
//                    print("ssss")
//                }
                Help.wait=false
            }
            i+=1
            //break
            
        }
    }
}


