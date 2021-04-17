//
//  CustomTable.swift
//  Sampling app
//
//  Created by Назарова on 13.04.2021.
//

import UIKit
@IBDesignable
class CustomTable: UIView, ButtonControllerDelegate {
   
    
    func didSelectButton(selectedButton: CustomButton?, index: Int) {
        let i = findSelect()
     
      
       //            self.delegate?.customTableViewCell(self, indexButton: i)
        UserDefaults.standard.setValue(i, forKey: String(question)+"_"+String(index_pos))
        HelpFunction.addDict(position: question, index:index_pos)
    }
    
    func findSelect()->Int{
    
            for i in 0..<buttons.count {
                if buttons[i].isSelected==true{
                    return i
                }
            }
            return -1
        }
    internal init(numbers: Int, text: String = "placeholer",index: Int,question: Int, val: Int, frame:CGRect) {
        super.init(frame: frame)
        for i in 0..<4{
            arrayNumbers.append(i)
        }
        self.text=text
        self.index_pos = index
        self.question = question
      //  self.value=val
        configure()
    }
    

    var buttonController: ButtonsController?
    var buttons: [CustomButton] = [CustomButton]()
    var arrayNumbers: [Int] = [Int] ()
    var label: UILabel = UILabel()
    var index_pos: Int = -1
    var question: Int = -1
    var value: Int = -1
    
    @IBInspectable
    var text: String = "hhh"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
         configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure(){
        label.text=text
        label.textColor=UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.frame = CGRect(x: 5, y: 5, width: 40, height: 14)
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: -2).isActive=true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive=true
        buttonsConfigure()
        //label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive=true
    }
    
    func buttonsConfigure(){
       
        var size: CGFloat = 35
        var distance = (self.bounds.width)/CGFloat(arrayNumbers.count)-CGFloat(size*CGFloat(arrayNumbers.count))//(self.bounds.width)/CGFloat(arrayNumbers.count+1)+size
        
        for i in 0...arrayNumbers.count{
            var button = CustomButton()
            button.frame = CGRect(x: 0, y: 0, width: size, height: size)
            button.index = i
            button.backgroundColor = color.UIColorFromRGB(rgbValue: 0xF6F6F6)
            button.setTitle(String(i+1), for: .normal)
            button.setTitleColor(UIColor.darkGray, for: .normal)
            button.layer.cornerRadius = button.bounds.width/2
           
            if i==value{
                button.isSelected=true
            }
           
            //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            if i==0{
                button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -distance).isActive=true
            }else{
                button.leftAnchor.constraint(equalTo: buttons[i-1].rightAnchor, constant: -distance).isActive=true
            }
            
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive=true
            button.heightAnchor.constraint(equalToConstant: size).isActive=true
            button.widthAnchor.constraint(equalToConstant: size).isActive=true
            buttons.append(button)
           // x+=CGFloat(20)+distance+200
        }
        //self.clipsToBounds=true
        //}
        self.isUserInteractionEnabled = true
        buttonController = ButtonsController(buttons: buttons)
       buttonController!.delegate = self
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
