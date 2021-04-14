////
////  CustomTableViewCell.swift
////  CustomTableViewCell
////
////  Created by ProgrammingWithSwift on 2020/03/30.
////  Copyright © 2020 ProgrammingWithSwift. All rights reserved.
////
//
//import UIKit
//protocol CustomTableViewCellDelegate: AnyObject {
//  func customTableViewCell(_ customTableViewCell: CustomTableViewCell, indexButton: Int)
//}
//class CustomTableViewCell: UIViewController , ButtonControllerDelegate {
//   
//    
//
//    weak var delegate : CustomTableViewCellDelegate?
//    var index:Int = -1
//    var index_row: Int {
//        get {
//            return index
//        }
//        set (new_val) {
//            index = new_val
//        }
//    }
//
//    func didSelectButton(selectedButton: CustomButton?) {
//        //print("yes")
//
//        if delegate != nil{
//            let i = findSelect()
//            self.delegate?.customTableViewCell(self, indexButton: i)
//
//                }
//        }
//
//    func findSelect()->Int{
//
//        for i in 0..<buttons.count {
//            if buttons[i].isSelected==true{
//                return i
//            }
//        }
//        return -1
//    }
//    var radioButtonController: ButtonsController?
//
//    @IBOutlet weak var labelName: UILabel!
//
//    @IBOutlet weak var button1: CustomButton!
//    @IBOutlet weak var button2: CustomButton!
//    @IBOutlet weak var button3: CustomButton!
//    @IBOutlet weak var button4: CustomButton!
//    @IBOutlet weak var button5: CustomButton!
//    var buttons: [CustomButton] = [CustomButton]()
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        radioButtonController = ButtonsController(buttons: button1, button2, button3, button4, button5)
//        button5.index=1
//       // setIndexButton()
//        buttons.append(contentsOf:[button1, button2, button3, button4, button5])
//
//       radioButtonController!.delegate = self
//      // radioButtonController!.shouldLetDeSelect = true
//
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//}
