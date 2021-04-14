//
//  CustomViewInstruction.swift
//  Sampling app
//
//  Created by Назарова on 13.04.2021.
//

import UIKit

@IBDesignable
class CustomViewInstruction: UIView {
  
    

    @IBInspectable
    var text: String = "Cnhejjhhgyfyfkgjkhjhkihkugjugfchgkhlhkgjfhdfgdggjkhjuggdcghjgxjughtdccc"
    
    var closeButton: UIButton = UIButton()
    var label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
         configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
         configure()
    }

    private func configure(){
        closeButton = getCloseButton()
        label = getInstructionLabel()
        self.addSubview(closeButton)
        self.addSubview(label)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive=true
        closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 2).isActive=true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 4).isActive=true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive=true
        label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive=true
       // label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive=true
        self.sizeToFit()
        
         //button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: self, action: Selector("someAction"))

    }
    func getCloseButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        //button.setTitleColor(color.UIColorFromRGB(rgbValue: 0x4198FF), for: .normal)
        button.setTitleColor(UIColor(hex: "#4198FF"), for: .normal)
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
 
        return button
    }
    
    func getInstructionLabel() ->UILabel{
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width-20, height: self.frame.height+10)
        label.text=text
        label.textColor=UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        
        return label
        //label.frame = CGRect(x: 5, y: 5, width: 125, height: 12)
        //self.addSubview(lables[0])
        //label[0].translatesAutoresizingMaskIntoConstraints = false
        //label.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive=true
        //label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive=true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
