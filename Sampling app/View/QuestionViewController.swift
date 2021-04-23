//
//  QuestionViewController.swift
//  Sampling app
//
//  Created by Назарова on 01.03.2021.
//

import UIKit

class QuestionViewController: UIViewController, RadioButtonControllerDelegate, AffectGridDelegate, CustomSliderDelegate, CustomSliderLabelsDelegate /*MultipleChoiceDelegate*/ {
//    func multipleChoice(_ multipleChoice: CustomMultipleChoice, index: Int) {
//        defaults.setValue(multipleChoice.isSelected, forKey: String(questionNumber)+"_"+String(index))
//        if multipleChoice.isSelected{
//            HelpFunction.addDict(position: questionNumber, index:index)
//        }
//        else{
//            HelpFunction.removeFromDict(position: questionNumber, index:index)
//        }
//    }
    
    
    
    func customSliderLabelsMovement(customSliderLabels: CustomSliderLabels?, value: Float, index: Int) {
        
        defaults.setValue(value, forKey: String(questionNumber)+"_"+String(index))
        HelpFunction.addDict(position: questionNumber, index:index)
    }
    
    func customSliderMovement(customSlider: CustomSlider?, value: Float,  index: Int) {
        
        defaults.setValue(value, forKey: String(questionNumber)+"_"+String(index))
        HelpFunction.addDict(position: questionNumber, index:index)
    }
    
    func affectGridLocation(_ affectGrid: CustomViewAffectGrid, location: CGPoint) {
        defaults.setValue(NSCoder.string(for: location), forKey: String(questionNumber)+"_"+"0")
        HelpFunction.addDict(position: questionNumber, index:-1)
    }
    
//    func customTableViewCell(_ customTableViewCell: CustomTableViewCell, indexButton: Int) {
//
//        defaults.setValue(indexButton, forKey: String(questionNumber)+"_"+String(customTableViewCell.index_row))
//        HelpFunction.addDict(position: questionNumber, index:customTableViewCell.index_row)
//    }
    
    func didSelectButton(selectedButton: RadioButton?, index:Int) {
        if index != -1{
            defaults.setValue(index, forKey: String(questionNumber)+"_"+"0")
            HelpFunction.addDict(position: questionNumber, index:-1)
        }
    }
    
    let data = ["One","Two","Three","Four","Five","Six","Seven","Eight"]
    var questionNumber:Int=1
//    var isFirstQuestion:Bool=true
    let defaults = UserDefaults.standard
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lableQuestionNumber: UILabel!
    @IBOutlet weak var labelQuestionText: UILabel!
    
    
    @IBOutlet weak var labelHint: UILabel!
    
   // @IBOutlet weak var buttonReturn: CustomButton!
  //  @IBOutlet weak var buttonNextQuestion: CustomButtonBase!
    
    //@IBOutlet weak var heightView: NSLayoutConstraint!
    //@IBOutlet weak var viewQuestion: CustomView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    ///_______________________________________________________________
  //  @IBOutlet weak var buttonNextBottonConstraint: NSLayoutConstraint!
   // @IBOutlet weak var sliderSuperView: NSLayoutConstraint!
    //@IBOutlet weak var heightSuperMain: NSLayoutConstraint!
    @IBOutlet weak var heightVV: NSLayoutConstraint!
    
   // @IBOutlet weak var buttonPreBottomConstraint: NSLayoutConstraint!
    ///______________________________________________________________
    
    //@IBOutlet weak var labelHint: UILabel!
    @IBOutlet weak var viewInstruction: CustomViewInstruction!
    
    @IBOutlet weak var constrainInstructionHeight: NSLayoutConstraint!
    
    //var contrainContinueTop: NSLayoutConstraint = NSLayoutConstraint()
    var originHeight: CGFloat = 0
    ///______________________________________________________________
    var radioButtonController: RadioButtonsController?
    //var buttonController: ButtonsController?
   
    weak var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        mainView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        self.viewInstruction.closeButton.isHidden = true
        self.viewInstruction.label.isHidden=true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        viewInstruction.closeButton.addGestureRecognizer(tap)
        print(questionNumber, " " , HelpFunction.questionArr.count)
        viewInstruction.label.text = HelpFunction.questionArr[questionNumber-1]["instructionText"] as! String
        labelQuestionText.text = HelpFunction.questionArr[questionNumber-1]["questionText"] as! String
        labelHint.text =  HelpFunction.questionArr[questionNumber-1]["questionSubtext"] as! String
         timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
        if HelpFunction.isTest == true{
            openInstructionForAll()
        }
        getQuestion()
    }
    @objc func updateCounting(){
        let curr_notif = UserDefaults.standard.object(forKey: "CurrTimeForNotif") as! Date
       // UserDefaults.standard.setValue(false, forKey: "BeginNotif")
       // let currIndex = UserDefaults.standard.object(forKey: "currIndex")as! Int
      // let d = UserNotification.fetchNotif(date_curr: Date())
       // let nearest = UserNotification.findNearest(data: d).value(forKey: "date") as! Date
        let minutes = curr_notif.minutes(from: Date())
        print()
       // print("minup",minutes)
        if abs(minutes)>=20{
           // UserDefaults.standard.setValue(currIndex+1, forKey: "currIndex")
            timer?.invalidate()
            var entries = UserDefaults.standard.string(forKey: "entries")
                        entries!+="F "
                        UserDefaults.standard.setValue(entries, forKey: "entries")
            var help = HelpFunction()
            help.sendDefault()
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
                        self.navigationController?.pushViewController(viewController, animated: false)
        }
//        let curr_notif = UserDefaults.standard.object(forKey: "CurrTimeForNotif") as! Date
//       // print("currup",curr_notif)
//
//        let minutes = curr_notif.minutes(from: Date())
//        UserDefaults.standard.setValue(false, forKey: "BeginNotif")
//        let currIndex = UserDefaults.standard.object(forKey: "currIndex")as! Int
//       //
//        print("minup",minutes)
//        if abs(minutes)<=20{
//            UserDefaults.standard.setValue(currIndex+1, forKey: "currIndex")
//            var entries = UserDefaults.standard.string(forKey: "entries")
//            entries!+="F "
//            UserDefaults.standard.setValue(entries, forKey: "entries")
//            HelpFunction.sendDefault()
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let viewController = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
//            self.navigationController?.pushViewController(viewController, animated: false)
//        }
       
    }
    
    @objc
    private func didTap(recognizer: UITapGestureRecognizer) {//change


          UIView.animate(withDuration: 0.7, delay: 0.1, options: [.curveEaseOut], animations: {
            self.heightVV.constant=self.originHeight
            self.constrainInstructionHeight.constant=2
           
            self.view.layoutIfNeeded()
          }, completion: { finished in
            self.viewInstruction.closeButton.isHidden = true
            self.viewInstruction.label.isHidden=true
          })
        
        
    }
    
    
    
    @IBAction func openInstruction(_ sender: Any) {
        openInstructionForAll()
      
    }
    
    func openInstructionForAll(){
        constrainInstructionHeight.constant=viewInstruction.label.bounds.size.height+10+viewInstruction.closeButton.bounds.height
            originHeight = self.heightVV.constant
        self.viewInstruction.closeButton.isHidden = false
        self.viewInstruction.label.isHidden=false
        UIView.animate(withDuration: 0.7, delay: 0.1, options: [.curveEaseOut], animations: {
            //self.updateConstraints(number: 40)
            self.heightVV.constant=self.originHeight+self.viewInstruction.label.bounds.size.height+10+self.viewInstruction.closeButton.bounds.height
            self.view.layoutIfNeeded()
          }, completion: { finished in
           
          })
    }
    
    
    func buttonForPages(){
        // isFirstQuestion=true
//        if questionNumber == 1{
//            // buttonReturn.removeFromSuperview()
//        }
        //buttonNextQuestion.removeFromSuperview()
        var buttonNext: UIButton = UIButton()
        if questionNumber == HelpFunction.questionArr.count || (HelpFunction.isReturn == true && HelpFunction.questions.last == questionNumber){
            buttonNext.setTitle("Закончить", for: .normal)
        }
        else{
            
            buttonNext.setTitle("Продолжить", for: .normal)
        }
        buttonNext = SetStyle.setButtonStyle(button: buttonNext)
//        buttonNext.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
//        buttonNext.setTitleColor(color.UIColorFromRGB(rgbValue: 0x4198FF), for: .normal)
//        buttonNext.layer.borderColor = color.UIColorFromRGB(rgbValue: 0x4198FF).cgColor
//        buttonNext.layer.borderWidth=1
//        buttonNext.layer.cornerRadius=24
        mainView.addSubview(buttonNext)
        buttonNext.translatesAutoresizingMaskIntoConstraints = false
        buttonNext.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20).isActive=true
        buttonNext.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive=true
        buttonNext.heightAnchor.constraint(equalToConstant: 50).isActive=true
        buttonNext.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        if questionNumber != 1 && !(HelpFunction.isReturn == true && HelpFunction.questions.first == questionNumber){
            var buttonReturn: UIButton = UIButton()
            // buttonReturn.setTitle("Продолжить", for: .normal)
            let image = UIImage(systemName: "arrow.turn.up.left")
            buttonReturn.setImage(image, for: .normal)
            buttonReturn = SetStyle.setButtonStyle(button: buttonReturn)
//            buttonReturn.setTitleColor(color.UIColorFromRGB(rgbValue: 0x4198FF), for: .normal)
//            buttonReturn.layer.borderColor = color.UIColorFromRGB(rgbValue: 0x4198FF).cgColor
//            buttonReturn.layer.borderWidth=1
//            buttonReturn.layer.cornerRadius=24
            mainView.addSubview(buttonReturn)
            buttonReturn.translatesAutoresizingMaskIntoConstraints = false
            buttonNext.leftAnchor.constraint(equalTo: buttonReturn.rightAnchor, constant: 7).isActive=true
            buttonReturn.widthAnchor.constraint(equalToConstant: 45).isActive=true
            buttonReturn.heightAnchor.constraint(equalToConstant: 45).isActive=true
            buttonReturn.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20).isActive=true
            buttonReturn.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive=true
            buttonReturn.addTarget(self, action: #selector(buttonPreAction), for: .touchUpInside)
            
        }
        else{
            buttonNext.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive=true
            
        }
        
    }
    
    @objc func buttonPreAction(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
        if HelpFunction.isReturn == true{
            
            viewController.questionNumber = HelpFunction.getPrevForgetQuestionNumber()
            
        }
        else{
            viewController.questionNumber=self.questionNumber-1
        }
        timer?.invalidate()
        self.navigationController?.popViewController(animated: true)
    }

    
    @objc func buttonAction(sender: UIButton!) {
      // print(self.questionNumber+1 == 6 || HelpFunction.questions.count == HelpFunction.pos || (HelpFunction.isReturn == true && HelpFunction.questions.isEmpty == true))
        if self.questionNumber == HelpFunction.questionArr.count || HelpFunction.questions.count == HelpFunction.pos || (HelpFunction.isReturn == true && HelpFunction.questions.isEmpty == true){
            if HelpFunction.checkReceiveAllAnswers()==true{
                timer?.invalidate()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "ViewAllCorrect") as! ViewAllCorrect
                //viewController.questionNumber=self.questionNumber+1
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            else{
                timer?.invalidate()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "ViewNotFull") as! ViewNotFull
                //viewController.questionNumber=self.questionNumber+1
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        } else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
            if HelpFunction.isReturn == true{
                
                viewController.questionNumber = HelpFunction.getNextForgetQuestionNumber()
            }
            else{
                viewController.questionNumber=self.questionNumber+1
            }
            
            timer?.invalidate()
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
    }
    
    
    func getQuestion(){
        
        HelpFunction.questionArr.sort { ($0["questionNumber"] as! Int) < ($1["questionNumber"] as! Int) }

        let type = HelpFunction.questionArr[questionNumber-1]["questionType"] as! String
        //HelpFunction.questionsLook.sorted(by: { $0.ID < $1.ID })
        lableQuestionNumber.text!+=" "+String(questionNumber)
        print("type ",type)
        if type == "Slider"{
            generateSliders(number: 1)
        }
        else if type == "DiscreteSlider"
        {
            generateSimpleSlider(number: (HelpFunction.questionArr[questionNumber-1]["scaleTexts"] as! [String]).count)
        }else if type == "AffectGrid"{
            generateAffectGrid()
            
        }else if type == "Choose"{
            generateRadioGroup(number: (HelpFunction.questionArr[questionNumber-1]["answers"] as! [String]).count)
        }
//        if questionNumber==1{
//            generateRadioGroup(number: 3)
//        }
//        else if questionNumber==2{
//            generateSimpleSlider(number: 3)
//        }
//        else if questionNumber==3{
//            generateTableView(number: 8)
//        }
//        else if questionNumber==4 {
//            generateAffectGrid()
//        }
//        else if questionNumber==5{
//            generateSliders(number: 3)
//        }
//        else{
//            generateMyltipleChoiceQuestion(number: 3)
//        }
        buttonForPages()
        
    }
    
    func updateConstraints(number:CGFloat){
        heightVV.constant+=number+70
        // heightView.constant+=number
        //heightSuperMain.constant+=number
        // buttonNextQuestion.translatesAutoresizingMaskIntoConstraints = false
        
        //buttonNextQuestion.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive=true
        // buttonNextBottonConstraint.constant-=number-30
        // buttonNextQuestion.frame = CGRect(x: buttonNextQuestion.frame.origin.x+number, y: buttonNextQuestion.frame.origin.y, width: buttonNextQuestion.frame.width, height: buttonNextQuestion.frame.height)
        // if questionNumber != 1{
        //  buttonPreBottomConstraint.constant-=number
        //     buttonReturn.frame = CGRect(x: buttonReturn.frame.origin.x+number, y: buttonReturn.frame.origin.y, width: buttonNextQuestion.frame.width, height: buttonReturn.frame.height)
        // }
        
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return defaults.object(forKey: key) != nil && defaults.string(forKey: key) != ("-9999") && defaults.string(forKey: key) != ("{-1000, -1000}")
    }
    func generateSliders(number:Int){
        var sliders: [CustomSlider] = [CustomSlider]()
        var height=0
        var value:Float = 0
        
        for i in 0..<number{
            value = 5
            if isKeyPresentInUserDefaults(key: String(questionNumber)+"_"+String(i))==true{
                value = defaults.object(forKey: String(questionNumber)+"_"+String(i)) as! Float
                
            }
            else{
                defaults.setValue( -9999, forKey: String(questionNumber)+"_"+String(i))
            }
           // HelpFunction.questionArr[questionNumber]["sliderMinValue"] as! Int
           // HelpFunction.questionArr[questionNumber]["sliderMaxValue"] as! Int
            
            var slider: CustomSlider = CustomSlider(value_my: value, frame: self.view.frame, min:  HelpFunction.questionArr[questionNumber-1]["sliderMinValue"] as! Float, max:  HelpFunction.questionArr[questionNumber-1]["sliderMaxValue"] as! Float)
            slider.delegate=self
            slider.value=((HelpFunction.questionArr[questionNumber-1]["sliderMinValue"] as! Float) +  (HelpFunction.questionArr[questionNumber-1]["sliderMaxValue"] as! Float))/2
            //slider.maximumValue=10
            //slider.minimumValue=0
            slider.index_pos = i
            slider.minimumTrackTintColor = color.UIColorFromRGB(rgbValue: 0x6C6C6C)
            slider.maximumTrackTintColor = color.UIColorFromRGB(rgbValue: 0x6C6C6C)
            if HelpFunction.questionArr[questionNumber-1]["isDiscrete"] as! Int == 0{
                slider.isTick = false
            }else{
                slider.isTick = true
            }
           
//            if value != 5 {
//            slider.value=value
//            }
            mainView.addSubview(slider)
            slider.translatesAutoresizingMaskIntoConstraints = false
            if i==0{
                //slider.isTick=true
                //slider.topAnchor.constraint(equalTo: viewQuestion.bottomAnchor, constant: 57).isActive=true
                slider.topAnchor.constraint(equalTo: viewInstruction.bottomAnchor, constant: 57).isActive=true
            }
            else{
                slider.topAnchor.constraint(equalTo: sliders[i-1].bottomAnchor, constant: 60).isActive=true
                
            }
            
            slider.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive=true
            slider.widthAnchor.constraint(equalToConstant: 275).isActive=true
            slider.heightAnchor.constraint(equalToConstant: 31).isActive=true
            height+=31+75
            
            sliders.append(slider)
            if height>=580{
                updateConstraints(number: 40)
                height-=100
            }
            
        }
        mainView.sizeToFit()
    }
    func generateSimpleSlider(number: Int){
        var sliders: [CustomSliderLabels]=[CustomSliderLabels]()
        var height=0
        for i in 0..<number{
            var value : Float = 0
            var text = ""
            if isKeyPresentInUserDefaults(key: String(questionNumber)+"_"+String(i))==true{
                value = defaults.object(forKey: String(questionNumber)+"_"+String(i)) as! Float
                
                text=String(Int(value))
            }
            else{
                defaults.setValue( -9999, forKey: String(questionNumber)+"_"+String(i))
            }
            //(HelpFunction.questionArr[questionNumber]["scaleText"] as [String])[0]
            var slider: CustomSliderLabels = CustomSliderLabels(text: text, frame: view.frame)
            slider.delegate=self
            slider.segments =  (HelpFunction.questionArr[questionNumber-1]["scaleTexts"] as! [String])[i]
            
            slider.maximumValue = HelpFunction.questionArr[questionNumber-1]["discreteSliderMaxValue"] as! Float
            slider.minimumValue = HelpFunction.questionArr[questionNumber-1]["discreteSliderMinValue"] as! Float
            slider.index_pos = i
            slider.minimumTrackTintColor = color.UIColorFromRGB(rgbValue: 0x6C6C6C)
            slider.maximumTrackTintColor = color.UIColorFromRGB(rgbValue: 0x6C6C6C)
            slider.value=value
            mainView.addSubview(slider)
            slider.translatesAutoresizingMaskIntoConstraints = false
            if i==0{
                //slider.topAnchor.constraint(equalTo: viewQuestion.bottomAnchor, constant: 57).isActive=true
                slider.topAnchor.constraint(equalTo: viewInstruction.bottomAnchor, constant: 57).isActive=true
            }
            else{
                slider.topAnchor.constraint(equalTo: sliders[i-1].bottomAnchor, constant: 60).isActive=true
                
            }
            slider.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -26).isActive=true
            slider.widthAnchor.constraint(equalToConstant: 275).isActive=true
            slider.heightAnchor.constraint(equalToConstant: 31).isActive=true
            height+=31+75
            
            sliders.append(slider)
            if height>=580{
                updateConstraints(number: 40)
                height-=100
            }
            
        }
        mainView.sizeToFit()
        
    }
    
    
    
    func generateRadioGroup(number:Int){
        var buttons:[RadioButton] = [RadioButton]()
        var height=0
        var selectButton:Int = -1
        if isKeyPresentInUserDefaults(key: String(questionNumber)+"_"+"0")==true{
            
            selectButton = defaults.object(forKey: String(questionNumber)+"_"+"0") as! Int
        }
        else{
            defaults.setValue( -9999, forKey: String(questionNumber)+"_"+"0")
        }
        for i in 0..<number{
            var button: RadioButton = RadioButton()
            //HelpFunction.questionArr[questionNumber]["answers"] as! [String]
            button.setTitle( (HelpFunction.questionArr[questionNumber-1]["answers"] as! [String])[i], for: .normal)
            button.setTitleColor(color.UIColorFromRGB(rgbValue: 0x6C6C6C), for: .normal)
            button.circleRadius=15
            mainView.insertSubview(button,at:0)
            button.translatesAutoresizingMaskIntoConstraints = false
            if i==0{
               // button.topAnchor.constraint(equalTo: viewQuestion.bottomAnchor, constant: 57).isActive=true
                button.topAnchor.constraint(equalTo: viewInstruction.bottomAnchor, constant: 57).isActive=true
            }
            else{
                button.topAnchor.constraint(equalTo: buttons[i-1].bottomAnchor, constant: 60).isActive=true
                
            }
            button.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 40).isActive=true
            button.widthAnchor.constraint(equalToConstant: 150).isActive=true
            button.heightAnchor.constraint(equalToConstant: 30).isActive=true
            height+=31+75
            
            if selectButton==i{
                button.isSelected = true
            }
            buttons.append(button)
            if height>=580{
                updateConstraints(number: 40)
                height-=70
            }
            
            
            
        }
        radioButtonController = RadioButtonsController(buttons: buttons)
        radioButtonController!.delegate = self
       // radioButtonController!.shouldLetDeSelect = true
    }
    
    ///______________________________________________________________________
    func generateTableView(number: Int){
        var height=0
        var tables:[CustomTable] = [CustomTable]()
        var val:Int = -1
        for i in 0..<number{
            val = -1
            if isKeyPresentInUserDefaults(key: String(questionNumber)+"_"+String(i))==true{
                val = defaults.object(forKey: String(questionNumber)+"_"+String(i)) as! Int
            }
            else{
    
                    defaults.setValue( -9999, forKey: String(questionNumber)+"_"+String(i))
            
            }
            var table = CustomTable(numbers: 5, index: i, question: questionNumber, val:val, frame: CGRect(x: 0, y: 0, width: self.mainView.bounds.width-10, height: 50))
            //table.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width-10, height: 30)
            table.clipsToBounds = true
          //  print(val, "dd")
            if val != -1{
                table=toggleButton(table:table, val:val)
            }

            //table.backgroundColor = UIColor.black

            mainView.addSubview(table)
           
            table.translatesAutoresizingMaskIntoConstraints = false
            if i==0{
                table.topAnchor.constraint(equalTo: viewInstruction.bottomAnchor, constant: 57).isActive=true
            }
            else{
                table.topAnchor.constraint(equalTo: tables[i-1].bottomAnchor, constant: 10).isActive=true
            }
            table.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: -10)
            table.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10)
            table.widthAnchor.constraint(equalToConstant: 400).isActive=true
            table.heightAnchor.constraint(equalToConstant: 60).isActive=true
            height+=60
            
            tables.append(table)
            if height>=60*6+57{
                updateConstraints(number: 80)
                height-=100
            }
            
        }
       
//        var tableview: ContentSizedTableView = ContentSizedTableView()
//        tableview.translatesAutoresizingMaskIntoConstraints = false
//        tableview.dataSource = self
//        tableview.delegate = self
//        
//        tableview.frame=CGRect(x: 25, y: 277, width: 320, height: data.count*100)
//        tableview.showsHorizontalScrollIndicator=false
//        tableview.showsVerticalScrollIndicator=false
//        tableview.bounces=false
//        tableview.isScrollEnabled=false
//        tableview.separatorStyle = .none
//        tableview.allowsSelection=false
//        self.registerTableViewCells(tableview: tableview)
//        mainView.addSubview(tableview)
//       // tableview.topAnchor.constraint(equalTo: viewQuestion.bottomAnchor, constant: 57).isActive=true
//        tableview.topAnchor.constraint(equalTo: viewInstruction.bottomAnchor, constant: 57).isActive=true
//        tableview.widthAnchor.constraint(equalToConstant: 320).isActive=true
//        tableview.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive=true
//        
//        
//        var  height = data.count*80
//        while height>=580{
//            updateConstraints(number: 40)
//            height-=60
//        }
//        tableview.sizeToFit()
        
        
    }
    func toggleButton(table:CustomTable, val:Int)->CustomTable{
      
        for i in 0..<table.buttons.count{
            
            if i==val{
                table.buttons[i].isSelected=true
            }
        }
        return table
    }
    func untoggleButton(table:CustomTable)->CustomTable{
        
        for i in 0..<table.buttons.count{
                table.buttons[i].isSelected=false
           
        }
        return table
    }
    
    
//    func tableView(_ tableView: UITableView,
//                   numberOfRowsInSection section: Int) -> Int {
//        return self.data.count
//    }
    
//    func tableView(_ tableView: UITableView,
//                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
//            cell.labelName.text = data[indexPath.row]
//            cell.delegate = self
//            cell.index_row = indexPath.row
//
//            if isKeyPresentInUserDefaults(key: String(questionNumber)+"_"+String(indexPath.row))==true{
//                print(indexPath.item, String(questionNumber)+"_"+String(indexPath.row))
//                if (defaults.integer(forKey: String(questionNumber)+"_"+String(indexPath.row)) != (-9999)){
//                    print("aa",indexPath.item, String(questionNumber)+"_"+String(indexPath.row))
//                    cell.buttons[defaults.integer(forKey: String(questionNumber)+"_"+String(indexPath.row))].isSelected = true
//
//                }
//
//            }
//            return cell
//        }
//
//        return UITableViewCell()
//    }
    
//    private func registerTableViewCells(tableview: ContentSizedTableView) {
//        let textFieldCell = UINib(nibName: "CustomTableViewCell",
//                                  bundle: nil)
//        tableview.register(textFieldCell,
//                           forCellReuseIdentifier: "CustomTableViewCell")
//    }
    ///______________________________________________________________________
    
    func generateAffectGrid(){
        
        var fin_loc: CGPoint = CGPoint(x: -1000, y: -1000)
        if isKeyPresentInUserDefaults(key: String(questionNumber)+"_"+"0")==true{
            let location = defaults.string(forKey: String(questionNumber)+"_"+"0")
            
            fin_loc = NSCoder.cgPoint(for: location!)
        }
        else{
            defaults.setValue(NSCoder.string(for: fin_loc), forKey: String(questionNumber)+"_"+"0")
        }
        let affectGrid: CustomViewAffectGrid = CustomViewAffectGrid(currLocation: fin_loc, frame: view.frame, isLine: true)
       // let upperX = HelpFunction.questionArr[questionNumber]["upperX"] as! String
        let upperXText = HelpFunction.questionArr[questionNumber-1]["upperXText"] as! String
        let lowerXText = HelpFunction.questionArr[questionNumber-1]["lowerXText"] as! String
        let upperYText = HelpFunction.questionArr[questionNumber-1]["upperYText"] as! String
        let lowerYText = HelpFunction.questionArr[questionNumber-1]["lowerYText"] as! String
        let leftUpperSquareText: String = HelpFunction.questionArr[questionNumber-1]["leftUpperSquareText"] as? String ?? ""
        let rightUpperSquareText: String = HelpFunction.questionArr[questionNumber-1]["rightUpperSquareText"] as? String ?? ""
        let leftLowerSquareText = HelpFunction.questionArr[questionNumber-1]["leftLowerSquareText"] as? String ?? ""
        let rightLowerSquareText = HelpFunction.questionArr[questionNumber-1]["rightLowerSquareText"] as? String ?? ""
        let arr = [leftUpperSquareText,upperYText,rightUpperSquareText, upperXText, lowerXText, leftLowerSquareText, lowerYText, rightLowerSquareText ]
        affectGrid.segments = arr //HelpFunction.questionArr[questionNumber]["answers"] as! [String]
        affectGrid.delegate=self
        affectGrid.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(affectGrid)
        affectGrid.topAnchor.constraint(equalTo: viewInstruction.bottomAnchor, constant: 57).isActive=true
        affectGrid.heightAnchor.constraint(equalToConstant: 360).isActive=true
        affectGrid.widthAnchor.constraint(equalToConstant: 360).isActive=true
        affectGrid.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive=true
        
        
    }
    
//    func generateMyltipleChoiceQuestion(number: Int){
//        var buttons: [CustomMultipleChoice]=[CustomMultipleChoice]()
//        var height=0
//        for i in 0..<number{
//            var value : Bool = false
//
//            if isKeyPresentInUserDefaults(key: String(questionNumber)+"_"+String(i))==true{
//                value = defaults.object(forKey: String(questionNumber)+"_"+String(i)) as! Bool
//
//            }
//            var button: CustomMultipleChoice = CustomMultipleChoice(isSelected: value, frame: view.frame)
//            button.delegate=self
//            button.segments = "First "+String(i)
//            button.index_pos = i
//            mainView.addSubview(button)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            if i==0{
//                button.topAnchor.constraint(equalTo: viewQuestion.bottomAnchor, constant: 57).isActive=true
//            }
//            else{
//                button.topAnchor.constraint(equalTo: buttons[i-1].bottomAnchor, constant: 60).isActive=true
//
//            }
//            button.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -26).isActive=true
//            button.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 35).isActive=true
//            button.widthAnchor.constraint(equalToConstant: 275).isActive=true
//            button.heightAnchor.constraint(equalToConstant: 31).isActive=true
//            height+=31+75
//
//            buttons.append(button)
//            if height>=580{
//                updateConstraints(number: 40)
//                height-=100
//            }
//
//        }
//        mainView.sizeToFit()
//
//    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
