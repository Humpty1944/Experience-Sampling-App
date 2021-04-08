//
//  CustomButton.swift
//  Sampling app
//
//  Created by Назарова on 19.02.2021.
//

import UIKit
@IBDesignable class CustomButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            toggleButon()
        }
    }
    func toggleButon() {
        if self.isSelected {
            self.backgroundColor = UIColor.systemBlue
            self.layer.borderColor = UIColor.systemBlue.cgColor
            self.setTitleColor(UIColor.white, for: .normal)
        } else {
            self.backgroundColor = color.UIColorFromRGB(rgbValue: 0xF6F6F6)
            self.layer.borderColor = color.UIColorFromRGB(rgbValue: 0xF6F6F6).cgColor
            self.setTitleColor(color.UIColorFromRGB(rgbValue: 0x6C6C6C), for: .normal)
        }
    }
}
@IBDesignable class CustomButtonBase: UIButton {
    
   
}
extension UIButton {
   
    /// Радиус гараницы
    @IBInspectable override var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue  }
        get { return layer.cornerRadius }
    }
    /// Толщина границы
    @IBInspectable override var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    /// Цвет границы
    @IBInspectable override var borderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor  }
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.blue as! CGColor) }
    }
}
