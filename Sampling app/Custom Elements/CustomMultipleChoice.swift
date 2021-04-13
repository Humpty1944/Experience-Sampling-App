//
//  ViewAffectGrid.swift
//  help
//
//  Created by Назарова on 23.02.2021.
//

import Foundation
import UIKit

protocol MultipleChoiceDelegate: AnyObject {
    func multipleChoice(_ multipleChoice: CustomMultipleChoice, index:Int)
}
@IBDesignable
final class CustomMultipleChoice: UIView {
    internal init(isSelected: Bool = false, frame: CGRect) {
        self.isSelected=isSelected
        super.init(frame: frame)
    }
    
    var index_pos:Int = -1
    
    var button: UIButton = UIButton()
    var label: UILabel = UILabel()
    var isSelected: Bool = false
    
    weak var delegate : MultipleChoiceDelegate?

    @IBInspectable
    var segments: String = "Cnheccc"
    
    
    // MARK: - Private properties
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // configure()
    }

   
    
    @objc
    private func didTap(recognizer: UITapGestureRecognizer) {//change
        
        
        button.isSelected = !isSelected
        
        isSelected = !isSelected
        
        if button.isSelected{
            button.layer.backgroundColor = UIColor.gray.cgColor
        }
        else{
            button.layer.backgroundColor = UIColor.white.cgColor
        }
        self.delegate?.multipleChoice(self, index:index_pos)
        
    }
    
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        button = UIButton(frame: CGRect(x: -10, y: -5, width: 30, height: 30))
        //button.frame = CGRect(x: -10, y: -5, width: 30, height: 30)
        button.layer.cornerRadius=10
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(UIColor.gray, for: .normal)
       
     
       // let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        button.addTarget(self, action: #selector(didTap(recognizer:)), for: .touchUpInside)
        //button.addGestureRecognizer(tap)
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive=true
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive=true
        
        button.heightAnchor.constraint(equalToConstant: 30).isActive=true
        
        button.widthAnchor.constraint(equalToConstant: 30).isActive=true
        label.text=segments
        label.textColor=UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.frame = CGRect(x: 25, y: 5, width: 125, height: 50)
        label.numberOfLines = 2
        

        self.addSubview(label)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        self.addGestureRecognizer(tap)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive=true
        label.widthAnchor.constraint(equalToConstant: 125).isActive=true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive=true
       
        
    }
    

    
}
