//
//  MainScreenViewController.swift
//  Sampling app
//
//  Created by Назарова on 17.02.2021.
//

import UIKit

class MainScreenViewController: UIViewController{
    
    
    var listOfView: [UIView]=[]
    var entryFill: [String]=["T","F","T","F", "T", "T","", "", "", ""]
    
    @IBOutlet weak var viewOfEntryFill: UIView!
    ///_______________________________________________
    @IBOutlet weak var labelEntryAll: UILabel!
    
    @IBOutlet weak var labelEntryForgot: UILabel!
    
    @IBOutlet weak var labelEntryLeft: UILabel!
    
    @IBOutlet weak var labelDaysLeft: UILabel!
    
    @IBOutlet weak var progressViewDaysLeft: UIProgressView!
    
    
    @IBOutlet weak var labelTimeBegin: UILabel!
    
    
    @IBOutlet weak var labelTimeEnd: UILabel!
    @IBOutlet weak var buttonDoTest: UIButton!

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var textViewMail: UITextView!
    @IBOutlet weak var textViewPhone: UITextView!
    @IBOutlet weak var labelDayN: UILabel!
    ///______________________________________
    weak var timer: Timer?
    var day = 1
    var dayLeft = 30
    var daysAll = 31
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        currentDay()
        HelpFunction.deleteAll()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(identifier: "ViewWelcome") as! ViewWelcome
//        self.navigationController?.pushViewController(viewController, animated: false)
       
      // UserDefaults.standard.setValue(true, forKey: "IsFirst")
       // print("fff", UserDefaults.standard.bool(forKey: "IsFirst"))
       // UserDefaults.standard.setValue("",forKey: "entries")
        
//                    var calendar = Calendar.current
//                    let hour_end = UserDefaults.standard.integer(forKey: "timeNotificationEnd.hours")
//                    let min_end = UserDefaults.standard.integer(forKey: "timeNotificationEnd.minutes")
//                    let hour_begin = UserDefaults.standard.integer(forKey: "timeNotificationStart.hours")
//                    let min_begin = UserDefaults.standard.integer(forKey: "timeNotificationStart.minutes")
//                    let end = calendar.date(bySettingHour: hour_end, minute: min_end, second: 0, of: Date())!
//                   let begin =  calendar.date(bySettingHour: hour_begin, minute: min_begin, second: 0, of: Date())!
//                    let quantity = UserDefaults.standard.integer(forKey:"notificationCountPerDay")
//                    let interval = UserDefaults.standard.integer(forKey:"notificationMinValueVariation")
//                    UserNotification.setNotification( begin, to: end, quantity: quantity, interval: interval)
//                    UserNotification.fetchNotif(date_curr: Date())
        if UserDefaults.standard.object(forKey: "IsFirst")==nil||UserDefaults.standard.bool(forKey: "IsFirst")==true{
            UserNotification.deleteAllData("Notifications")
            var calendar = Calendar.current
            let hour_end = UserDefaults.standard.integer(forKey: "timeNotificationEnd.hours")
            let min_end = UserDefaults.standard.integer(forKey: "timeNotificationEnd.minutes")
            let hour_begin = UserDefaults.standard.integer(forKey: "timeNotificationStart.hours")
            let min_begin = UserDefaults.standard.integer(forKey: "timeNotificationStart.minutes")
            let end = calendar.date(bySettingHour: hour_end, minute: min_end, second: 0, of: Date())!
           let begin =  calendar.date(bySettingHour: hour_begin, minute: min_begin, second: 0, of: Date())!
            let quantity = UserDefaults.standard.integer(forKey:"notificationCountPerDay")
            let interval = UserDefaults.standard.integer(forKey:"notificationMinValueVariation")
            UserNotification.setNotification( begin, to: end, quantity: quantity, interval: interval)
            UserNotification.fetchNotif(date_curr: Date())
            UserDefaults.standard.setValue(10, forKey: "All")

//            let d = UserNotification.fetchNotif(date_curr: Date())
//            do{
//            let find_date = try UserNotification.find(data: d, date: Date())
//            }catch{}
            UserDefaults.standard.setValue(false, forKey: "IsFirst")
//            UserDefaults.standard.setValue(true, forKey: "IsFirst")
//            UserDefaults.standard.setValue(false, forKey: "BeginNotif")
//            UserDefaults.standard.setValue(10, forKey: "All")
//            UserDefaults.standard.setValue("",forKey: "entries")
           
        }
        let d = UserNotification.fetchNotif(date_curr: Date())
        do{
            _ = try UserNotification.find(data: d, date: Date())
        }catch{}
        putData()
        createRect()
         timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
       // let curr_notif = UserDefaults.standard.object(forKey: "CurrTimeForNotif") as! Date
       // print("currup",curr_notif)

        //let minutes = curr_notif.minutes(from: Date())
        do{
        UserDefaults.standard.setValue(false, forKey: "BeginNotif")
       // let currIndex = UserDefaults.standard.object(forKey: "currIndex")as! Int
       let d = UserNotification.fetchNotif(date_curr: Date())
            let find = try UserNotification.findNearest(data: d)
        print(find)
        createRect()
            putData()
        let nearest = find.value(forKey: "date") as! Date
        let minutes = nearest.minutes(from: Date())
        print()
       // print("minup",minutes)
       print("notif", UserDefaults.standard.bool(forKey: "notif"))
        if abs(minutes)<=20 && UserDefaults.standard.bool(forKey: "notif") == false && minutes <= 0{
            timer?.invalidate()
            UserDefaults.standard.setValue(false, forKey: "notif")
            //UserDefaults.standard.setValue(currIndex+1, forKey: "currIndex")
            UserNotification.deleteNearest(data: d, date: find)
            UserDefaults.standard.setValue(nearest, forKey: "CurrTimeForNotif")
            let d = UserNotification.fetchNotif(date_curr: Date())
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "ViewWelcome") as! ViewWelcome
            self.navigationController?.pushViewController(viewController, animated: false)
        }
        else{
            var help = HelpFunction()
            help.sendDefault()
        }
        } catch {
            
        }
       
    }
    
    func putData(){
        labelName.text="Исследователь "+UserDefaults.standard.string(forKey: "nickname")!
        textViewMail.text=UserDefaults.standard.string(forKey: "email")
        textViewPhone.text=UserDefaults.standard.string(forKey: "phoneNumber")
        ///____________________________________
        labelTimeBegin.text=UserDefaults.standard.string(forKey: "timeNotificationStart.hours")!+":"+UserDefaults.standard.string(forKey: "timeNotificationStart.minutes")!+"0"
        labelTimeEnd.text=UserDefaults.standard.string(forKey: "timeNotificationEnd.hours")!+":"+UserDefaults.standard.string(forKey: "timeNotificationEnd.minutes")!+"0"
        ///____________________________________
        labelDaysLeft.text=String(dayLeft)//"12"
        progressViewDaysLeft.setProgress(Float((daysAll-dayLeft)/daysAll), animated: true)
        ///____________________________________
        let data = lookAtEntryFill()
        labelEntryAll.text=String(data[1])
        labelEntryLeft.text=String(data[0])
        labelEntryForgot.text=String(data[2])
        ///__________________________________
        labelDayN.text!="День "+String(day)//+String(1)
        
    }
    func lookAtEntryFill()->[Int]{
        var arrOfData:[Int]=[0,0,0]
        //arrOfData[0]=entryFill.count
        var entries: String = UserDefaults.standard.string(forKey: "entries")!
        let entry = entries.split(separator: " ")
        for i in 0..<entry.count{
            if (entry[i]=="T"){
                arrOfData[1]+=1
            } else if (entry[i]=="F"){
                arrOfData[2]+=1
            }
        }
        arrOfData[0] = UserDefaults.standard.integer(forKey: "All") - entry.count
//        for i in 0...entryFill.count-1{
//            if (entryFill[i]=="T"){
//                arrOfData[1]+=1
//            } else if (entryFill[i]=="F"){
//                arrOfData[2]+=1
//            }
//            else{
//                arrOfData[0]+=1
//            }
//        }
        return arrOfData
    }
    
    
    @IBAction func doTest(_ sender: Any) {
        timer?.invalidate()
        HelpFunction.isTestSet(val:true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ViewWelcome") as! ViewWelcome
        //navigationController?.setViewControllers([viewController], animated:true)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    
    func createRect(){
        var xPos = 13
        let yPos = 0
        let rectWidth = 18
        let rectHeight = 18
        var entries = UserDefaults.standard.string(forKey: "entries")
        let entry = entries?.split(separator: " ")
        //var i = 0
        for i in 0..<entry!.count{
            //print(entry![i], "ss")
            var rectFrame: CGRect = CGRect(x:CGFloat(xPos), y:CGFloat(yPos), width:CGFloat(rectWidth), height:CGFloat(rectHeight))
            var cubeView = UIView(frame: rectFrame)
            cubeView.layer.cornerRadius=2
            if (entry![i]=="T"){
                cubeView.backgroundColor = color.UIColorFromRGB(rgbValue: 0x4198FF)
            } else if (entry![i]=="F"){
                cubeView.backgroundColor = color.UIColorFromRGB(rgbValue: 0xFFAAAA)
            }
            if entry![i] != ""{
            viewOfEntryFill.addSubview(cubeView)
            listOfView.append(cubeView)
            xPos+=23
            }
        }
       
        let all = UserDefaults.standard.integer(forKey: "All")
        for i in 0 ..< 10{//UserDefaults.standard.integer(forKey: "All") - entry!.count{
            var rectFrame: CGRect = CGRect(x:CGFloat(xPos), y:CGFloat(yPos), width:CGFloat(rectWidth), height:CGFloat(rectHeight))
            var cubeView = UIView(frame: rectFrame)
            cubeView.layer.cornerRadius=2
            cubeView.backgroundColor = color.UIColorFromRGB(rgbValue: 0xDDDDDD)
            viewOfEntryFill.addSubview(cubeView)
            listOfView.append(cubeView)
            xPos+=23
        }
        }
    
    
    func currentDay(){
        let day_cur = Calendar.current.component(.day, from: Date())
        let month_cur = Calendar.current.component(.month, from: Date())
        let valDay = UserDefaults.standard.string(forKey: "dayCurr")
        let beginDay = UserDefaults.standard.string(forKey: "beginDay") ?? "2021-04-24T02:53:316"
        let endDay = UserDefaults.standard.string(forKey: "endDay") ?? "2021-04-26T02:53:316"
        var days = String(beginDay[8...9])
        let day_begin = Int(days)!
        days = String(endDay[8...9])
        let end_Day = Int(days)!
        if valDay == nil{
            UserDefaults.standard.setValue(String(day_cur)+" "+String(month_cur), forKey: "dayCurr")
        }
        else{
            let dateUser = valDay?.split(separator: " ")
            if String(day_cur) != dateUser![0] || String(month_cur) != dateUser![1]{
               
                 day =  abs(Date().get(.day) - day_begin)//abs(Int(beginDay.days(from: Date())))+1
                UserDefaults.standard.setValue("", forKey: "entries")
            }
        }
        //let endDay = UserDefaults.standard.object(forKey: "endDay") as! Date
        //print("end", endDay)
        dayLeft = abs(Date().get(.day) - end_Day) //abs(Int(endDay.days(from: Date())))-1
        daysAll = abs(end_Day-day_begin) //abs(Int(endDay.days(from:beginDay)))-1
        
    }
    }

    
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
