//
//  QuestionViewController.swift
//  Sampling app
//
//  Created by Назарова on 01.03.2021.
//

import UIKit

class QuestionViewController: UIViewController, RadioButtonControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    func didSelectButton(selectedButton: RadioButton?) {
        
    }
    
    let data = ["One","Two","Three","Four","Five","Six","Seven","Eight"]
    var questionNumber:Int=1
    var isFirstQuestion:Bool=true

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lableQuestionNumber: UILabel!
    @IBOutlet weak var labelQuestionText: UILabel!
    @IBOutlet weak var buttonReturn: CustomButton!
    @IBOutlet weak var buttonNextQuestion: CustomButtonBase!
    
    @IBOutlet weak var heightView: NSLayoutConstraint!
    @IBOutlet weak var viewQuestion: CustomView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    ///_______________________________________________________________
    @IBOutlet weak var buttonNextBottonConstraint: NSLayoutConstraint!
    @IBOutlet weak var sliderSuperView: NSLayoutConstraint!
    @IBOutlet weak var heightSuperMain: NSLayoutConstraint!
    @IBOutlet weak var heightVV: NSLayoutConstraint!
    
    @IBOutlet weak var buttonPreBottomConstraint: NSLayoutConstraint!
    ///______________________________________________________________
    var radioButtonController: RadioButtonsController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        mainView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        print(questionNumber)
       // if questionNumber==1{
         //   removeReturnButton()
       // }
        getQuestion()
        
        //removeReturnButtton()
        // Do any additional setup after loading the view.
    }
    func removeReturnButton(){
       // isFirstQuestion=true
        if questionNumber == 1{
       // buttonReturn.removeFromSuperview()
        }
        //buttonNextQuestion.removeFromSuperview()
        var buttonNext: UIButton = UIButton()
        buttonNext.setTitle("Продолжить", for: .normal)
        buttonNext.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        buttonNext.setTitleColor(color.UIColorFromRGB(rgbValue: 0x4198FF), for: .normal)
        buttonNext.layer.borderColor = color.UIColorFromRGB(rgbValue: 0x4198FF).cgColor
        buttonNext.layer.borderWidth=1
        buttonNext.layer.cornerRadius=24
        mainView.addSubview(buttonNext)
        buttonNext.translatesAutoresizingMaskIntoConstraints = false
        buttonNext.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20).isActive=true
        buttonNext.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive=true
        buttonNext.heightAnchor.constraint(equalToConstant: 50).isActive=true
        buttonNext.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        if questionNumber != 1{
            var buttonReturn: UIButton = UIButton()
           // buttonReturn.setTitle("Продолжить", for: .normal)
            let image = UIImage(systemName: "arrow.turn.up.left")
            buttonReturn.setImage(image, for: .normal)
            buttonReturn.setTitleColor(color.UIColorFromRGB(rgbValue: 0x4198FF), for: .normal)
            buttonReturn.layer.borderColor = color.UIColorFromRGB(rgbValue: 0x4198FF).cgColor
            buttonReturn.layer.borderWidth=1
            buttonReturn.layer.cornerRadius=24
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
        viewController.questionNumber=self.questionNumber-1
        self.navigationController?.popViewController(animated: true)
        }
    @IBAction func previousQuestion(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
        viewController.questionNumber=self.questionNumber-1
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("next")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
        viewController.questionNumber=self.questionNumber+1
        self.navigationController?.pushViewController(viewController, animated: true)
        }
    @IBAction func nextQuestion(_ sender: Any) {
        print("next")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
        viewController.questionNumber=self.questionNumber+1
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func getQuestion(){
        let help=Int.random(in: 0..<5)
        lableQuestionNumber.text!+=" "+String(questionNumber)
        if questionNumber==1{
            //generateTableView()
            //generateSimpleSlider(number: 7)
            generateRadioGroup(number: 7)
        }
        else if questionNumber==2{
            generateSimpleSlider(number: 7)
        }
        else if questionNumber==3{
            generateTableView()
        }
        else if questionNumber==4 {
            generateAffectionGrid()
        }
        else{
            generateSliders()
        }
        removeReturnButton()
        
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
    func generateSliders(){
        var sliders: [CustomSlider] = [CustomSlider]()
        var height=0
        for i in 0..<3{
            var slider: CustomSlider = CustomSlider()
            slider.maximumValue=10
            slider.minimumValue=0
            slider.minimumTrackTintColor = color.UIColorFromRGB(rgbValue: 0x6C6C6C)
            slider.maximumTrackTintColor = color.UIColorFromRGB(rgbValue: 0x6C6C6C)
            slider.value=5
            mainView.addSubview(slider)
            slider.translatesAutoresizingMaskIntoConstraints = false
            if i==0{
                slider.isTick=true
                slider.topAnchor.constraint(equalTo: viewQuestion.bottomAnchor, constant: 57).isActive=true
            }
            else{
                slider.topAnchor.constraint(equalTo: sliders[i-1].bottomAnchor, constant: 60).isActive=true

            }
            //slider.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 26).isActive=true
           // slider.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -26).isActive=true
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
            var slider: CustomSliderLabels = CustomSliderLabels()
            slider.segments = "First "+String(1)
            slider.maximumValue=10
            slider.minimumValue=0
            slider.minimumTrackTintColor = color.UIColorFromRGB(rgbValue: 0x6C6C6C)
            slider.maximumTrackTintColor = color.UIColorFromRGB(rgbValue: 0x6C6C6C)
            slider.value=5
            mainView.addSubview(slider)
            slider.translatesAutoresizingMaskIntoConstraints = false
            if i==0{
                slider.topAnchor.constraint(equalTo: viewQuestion.bottomAnchor, constant: 57).isActive=true
            }
            else{
                slider.topAnchor.constraint(equalTo: sliders[i-1].bottomAnchor, constant: 60).isActive=true

            }
            //slider.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 26).isActive=true
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
        for i in 0..<number{
            var button: RadioButton = RadioButton()
            button.setTitle("Test", for: .normal)
            button.setTitleColor(color.UIColorFromRGB(rgbValue: 0x6C6C6C), for: .normal)
            //button.titleLabel!.text = "Test"
            //button.frame=CGRect(x: 0, y: 0, width: 150, height: 30)
            //button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
            button.circleRadius=15
           // mainView.addSubview(button)
            mainView.insertSubview(button,at:0)
            button.translatesAutoresizingMaskIntoConstraints = false
            if i==0{
                button.topAnchor.constraint(equalTo: viewQuestion.bottomAnchor, constant: 57).isActive=true
            }
            else{
                button.topAnchor.constraint(equalTo: buttons[i-1].bottomAnchor, constant: 60).isActive=true

            }
            //slider.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 26).isActive=true
           // button.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -100).isActive=true
            button.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 40).isActive=true
            button.widthAnchor.constraint(equalToConstant: 150).isActive=true
            button.heightAnchor.constraint(equalToConstant: 30).isActive=true
            height+=31+75
//            if (i==number-1){
//                slider.bottomAnchor.constraint(equalTo: buttonNextQuestion.topAnchor, constant: 140).isActive=true
//
//            }
            buttons.append(button)
            if height>=580{
                updateConstraints(number: 40)
                height-=70
            }

        }
       radioButtonController = RadioButtonsController(buttons: buttons)
       radioButtonController!.delegate = self
       radioButtonController!.shouldLetDeSelect = true
    }
    
    ///______________________________________________________________________
    func generateTableView(){
        var tableview: ContentSizedTableView = ContentSizedTableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.delegate = self
       
        tableview.frame=CGRect(x: 25, y: 277, width: 320, height: data.count*100)
        tableview.showsHorizontalScrollIndicator=false
        tableview.showsVerticalScrollIndicator=false
        tableview.bounces=false
        tableview.isScrollEnabled=false
        tableview.separatorStyle = .none
        tableview.allowsSelection=false
        self.registerTableViewCells(tableview: tableview)
        mainView.addSubview(tableview)
        tableview.topAnchor.constraint(equalTo: viewQuestion.bottomAnchor, constant: 57).isActive=true
        tableview.widthAnchor.constraint(equalToConstant: 320).isActive=true
        tableview.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive=true
        //tableview.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0).isActive=true
        //tableview.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -40).isActive=true
        //tableview.heightAnchor.constraint(equalToConstant: CGFloat(data.count*80)).isActive=true
       // tableview.bottomAnchor.constraint(equalTo: buttonNextQuestion.topAnchor, constant: -733).isActive=true

        var  height = data.count*80
        while height>=580{
            updateConstraints(number: 40)
//            heightVV.constant+=100
//            heightView.constant+=100
//            heightSuperMain.constant+=100
//            buttonNextBottonConstraint.constant-=100
//            buttonPreBottomConstraint.constant-=100
//            buttonNextQuestion.frame = CGRect(x: buttonNextQuestion.frame.origin.x+100, y: buttonNextQuestion.frame.origin.y, width: buttonNextQuestion.frame.width, height: buttonNextQuestion.frame.height)
//            buttonReturn.frame = CGRect(x: buttonReturn.frame.origin.x+100, y: buttonReturn.frame.origin.y, width: buttonNextQuestion.frame.width, height: buttonReturn.frame.height)
            height-=60
        }
        tableview.sizeToFit()
        
        
    }
   

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
            cell.labelName.text = data[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    private func registerTableViewCells(tableview: ContentSizedTableView) {
        let textFieldCell = UINib(nibName: "CustomTableViewCell",
                                  bundle: nil)
        tableview.register(textFieldCell,
                                forCellReuseIdentifier: "CustomTableViewCell")
    }
    ///______________________________________________________________________

    func generateAffectionGrid(){
        var affectionGrid: ViewAffectGrid = ViewAffectGrid()
       affectionGrid.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(affectionGrid)
        affectionGrid.topAnchor.constraint(equalTo: viewQuestion.bottomAnchor, constant: 57).isActive=true
       // affectionGrid.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0).isActive=true
        //affectionGrid.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -40).isActive=true
        affectionGrid.heightAnchor.constraint(equalToConstant: 360).isActive=true
        affectionGrid.widthAnchor.constraint(equalToConstant: 360).isActive=true
        affectionGrid.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive=true
        //updateConstraints(number: 10)
//        heightVV.constant+=10
//        heightView.constant+=10
//        heightSuperMain.constant+=10
//        buttonNextBottonConstraint.constant-=10
//
//        buttonPreBottomConstraint.constant-=10
//        buttonNextQuestion.frame = CGRect(x: buttonNextQuestion.frame.origin.x+10, y: buttonNextQuestion.frame.origin.y, width: buttonNextQuestion.frame.width, height: buttonNextQuestion.frame.height)
//        buttonReturn.frame = CGRect(x: buttonReturn.frame.origin.x+10, y: buttonReturn.frame.origin.y, width: buttonNextQuestion.frame.width, height: buttonReturn.frame.height)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
