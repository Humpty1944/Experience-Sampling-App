//
//  CustomTableViewCell.swift
//  CustomTableViewCell
//
//  Created by ProgrammingWithSwift on 2020/03/30.
//  Copyright © 2020 ProgrammingWithSwift. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell, ButtonControllerDelegate {
    func didSelectButton(selectedButton: RadioButton?) {
        
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        print("yay")
    }
    
    var radioButtonController: ButtonsController?

    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        radioButtonController = ButtonsController(buttons: button1, button2, button3, button4, button5)
       radioButtonController!.delegate = self
       radioButtonController!.shouldLetDeSelect = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
