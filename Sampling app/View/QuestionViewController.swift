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
        defaults.setValue(NSCoder.string(for: location), forKey: String(questionNumber)+"_")
        HelpFunction.addDict(position: questionNumber, index:-1)
    }
    
//    func customTableViewCell(_ customTableViewCell: CustomTableViewCell, indexButton: Int) {
//
//        defaults.setValue(indexButton, forKey: String(questionNumber)+"_"+String(customTableViewCell.index_row))
//        HelpFunction.addDict(position: questionNumber, index:customTableViewCell.index_row)
//    }
    
    func didSelectButton(selectedButton: RadioButton?, index:Int) {
        if index != -1{
            defaults.setValue(index, forKey: String(questionNumber)+"_")
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
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        mainView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        self.viewInstruction.closeButton.isHidden = true
        self.viewInstruction.label.isHidden=true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        viewInstruction.closeButton.addGestureRecognizer(tap)

        getQuestion()
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
        if questionNumber == 5 || (HelpFunction.isReturn == true && HelpFunction.questions.last == questionNumber){
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
        self.navigationController?.popViewController(animated: true)
    }

    
    @objc func buttonAction(sender: UIButton!) {
       print(self.questionNumber+1 == 6 || HelpFunction.questions.count == HelpFunction.pos || (HelpFunction.isReturn == true && HelpFunction.questions.isEmpty == true))
        if self.questionNumber+1 == 6 || HelpFunction.questions.count == HelpFunction.pos || (HelpFunction.isReturn == true && HelpFunction.questions.isEmpty == true){
            if HelpFunction.checkReceiveAllAnswers()==true{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "ViewAllCorrect") as! ViewAllCorrect
                //viewController.questionNumber=self.questionNumber+1
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            else{
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
            
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
    }
    
    
    func getQuestion(){
        
        lableQuestionNumber.text!+=" "+String(questionNumber)
        if questionNumber==1{
            generateRadioGroup(number: 3)
        }
        else if questionNumber==2{
            generateSimpleSlider(number: 3)
        }
        else if questionNumber==3{
            generateTableView(number: 8)
        }
        else if questionNumber==4 {
            generateAffectGrid()
        }
        else if questionNumber==5{
            generateSliders(number: 3)
        }
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
        var value:Float = 5
        
        for i in 0..<number{
            value = 5
            if isKeyPresentInUserDefaults(key: String(questionNumber)+"_"+String(i))==true{
                value = defaults.object(forKey: String(questionNumber)+"_"+String(i)) as! Float
                
                
            }
          
            var slider: CustomSlider = CustomSlider(value_my: value, frame: self.view.frame, min: 0, max: 10)
            slider.delegate=self
            
            //slider.maximumValue=10
            //slider.minimumValue=0
            slider.index_pos = i
            slider.minimumTrackTintColor = color.UIColorFromRGB(rgbValue: 0x6C6C6C)
            slider.maximumTrackTintColor = color.UIColorFromRGB(rgbValue: 0x6C6C6C)
//            if value != 5 {
//            slider.value=value
//            }
            mainView.addSubview(slider)
            slider.translatesAutoresizingMaskIntoConstraints = false
            if i==0{
                slider.isTick=true
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
            var value : Float = 5.0
            var text = ""
            if isKeyPresentInUserDefaults(key: String(questionNumber)+"_"+String(i))==true{
                value = defaults.object(forKey: String(questionNumber)+"_"+String(i)) as! Float
                
                text=String(Int(value))
            }
            var slider: CustomSliderLabels = CustomSliderLabels(text: text, frame: view.frame)
            slider.delegate=self
            slider.segments = "First "+String(i)
            
            slider.maximumValue=10
            slider.minimumValue=0
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
        if isKeyPresentInUserDefaults(key: String(questionNumber)+"_")==true{
            
            selectButton = defaults.object(forKey: String(questionNumber)+"_") as! Int
        }
        for i in 0..<number{
            var button: RadioButton = RadioButton()
            
            button.setTitle("Test", for: .normal)
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
            var table = CustomTable(numbers: 5, index: i, question: questionNumber, val:val, frame: CGRect(x: 0, y: 0, width: self.mainView.bounds.width-10, height: 50))
            //table.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width-10, height: 30)
            table.clipsToBounds = true
            print(val, "dd")
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
        if isKeyPresentInUserDefaults(key: String(questionNumber)+"_")==true{
            let location = defaults.string(forKey: String(questionNumber)+"_")
            
            fin_loc = NSCoder.cgPoint(for: location!)
        }
        let affectGrid: CustomViewAffectGrid = CustomViewAffectGrid(currLocation: fin_loc, frame: view.frame, isLine: true)
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
