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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        createRect(size: entryFill.count)
        putData()
        HelpFunction.deleteAll()
    }
    
    func putData(){
        labelName.text="Исследователь "+"Иванов И. И."
        textViewMail.text="mail12344@mail.com"
        textViewPhone.text="+7912345678"
        ///____________________________________
        labelTimeBegin.text="9:00"
        labelTimeEnd.text="23:00"
        ///____________________________________
        labelDaysLeft.text="12"
       progressViewDaysLeft.setProgress(12/31, animated: true)
        ///____________________________________
        let data = lookAtEntryFill()
        labelEntryAll.text=String(data[0])
        labelEntryLeft.text=String(entryFill.count-data[1]-data[2])
        labelEntryForgot.text=String(data[2])
        ///__________________________________
        labelDayN.text!="День "+String(14)
        
    }
    func lookAtEntryFill()->[Int]{
        var arrOfData:[Int]=[0,0,0]
        //arrOfData[0]=entryFill.count
        for i in 0...entryFill.count-1{
            if (entryFill[i]=="T"){
                arrOfData[1]+=1
            } else if (entryFill[i]=="F"){
                arrOfData[2]+=1
            }
            else{
                arrOfData[0]+=1
            }
        }
        return arrOfData
    }
    
    
    @IBAction func doTest(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ViewWelcome") as! ViewWelcome
        //navigationController?.setViewControllers([viewController], animated:true)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    
    func createRect(size:Int){
        var xPos = 13
        let yPos = 0
        let rectWidth = 18
        let rectHeight = 18
        for i in 0...size-1{
            var rectFrame: CGRect = CGRect(x:CGFloat(xPos), y:CGFloat(yPos), width:CGFloat(rectWidth), height:CGFloat(rectHeight))
            var cubeView = UIView(frame: rectFrame)
            cubeView.layer.cornerRadius=2
            if (entryFill[i]=="T"){
                cubeView.backgroundColor = color.UIColorFromRGB(rgbValue: 0x4198FF)
            } else if (entryFill[i]=="F"){
                cubeView.backgroundColor = color.UIColorFromRGB(rgbValue: 0xFFAAAA)
            }
            else{
                cubeView.backgroundColor = color.UIColorFromRGB(rgbValue: 0xDDDDDD)
              
            }
          
            viewOfEntryFill.addSubview(cubeView)
            listOfView.append(cubeView)
            xPos+=23
        }
    }
}
    
