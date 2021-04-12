////
////  Question3.swift
////  Sampling app
////
////  Created by Назарова on 22.02.2021.
////
//
//import Foundation
//import UIKit
//
//class Question3: UIViewController, ButtonControllerDelegate{
//    func didSelectButton(selectedButton: UIButton?) {
//
//    }
//
//
//
//    @IBOutlet weak var button1: RadioButton!
//
//
//    @IBOutlet weak var button2: RadioButton!
//
//
//
//    @IBOutlet weak var button3: RadioButton!
//
//    var radioButtonController: ButtonsController?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//         radioButtonController = ButtonsController(buttons: button1, button2, button3)
//        radioButtonController!.delegate = self
//        radioButtonController!.shouldLetDeSelect = true
//    }
// //  func didSelectButton(selectedButton: RadioButton?)
//   //     {
//     //       NSLog(" \(selectedButton)" )
//       // }
//    @IBAction func nextQuestion(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(identifier: "Question4") as! Question4
//        //navigationController?.setViewControllers([viewController], animated:true)
//        self.navigationController?.pushViewController(viewController, animated: false)
//    }
//    @IBAction func previousQuestion(_ sender: Any) {
//        _ = navigationController?.popViewController(animated: true)
////            let storyboard = UIStoryboard(name: "Main", bundle: nil)
////            let viewController = storyboard.instantiateViewController(identifier: "QuestionControllerView") as! QuestionControllerView
////            //navigationController?.setViewControllers([viewController], animated:true)
////            self.navigationController?.pushViewController(viewController, animated: false)
//        }
//
//}
//
//
