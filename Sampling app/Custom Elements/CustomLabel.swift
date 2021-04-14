//
//  CustomLabel.swift
//  Sampling app
//
//  Created by Назарова on 22.02.2021.
//

import UIKit

@IBDesignable class CustomLabel: UILabel {}
extension UILabel{
    @IBInspectable
    override var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = self.bounds.width/2//newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    override var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    override var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}
