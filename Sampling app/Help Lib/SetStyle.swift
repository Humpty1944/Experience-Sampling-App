//
//  SetStyle.swift
//  Sampling app
//
//  Created by Назарова on 13.04.2021.
//

import Foundation
import UIKit
class  SetStyle: NSObject{
    
    static func setButtonStyle(button: UIButton)->UIButton{
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        button.setTitleColor(color.UIColorFromRGB(rgbValue: 0x4198FF), for: .normal)
        button.layer.borderColor = color.UIColorFromRGB(rgbValue: 0x4198FF).cgColor
        button.layer.borderWidth=1
        button.layer.cornerRadius=24
        return button
    }
}
