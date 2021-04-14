////
////  Question4.swift
////  Sampling app
////
////  Created by Назарова on 22.02.2021.
////
//
//import Foundation
//import UIKit
//
//class Question4: UIViewController{
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//    @IBAction func nextQuestion(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(identifier: "Question5") as! Question5
//        //navigationController?.setViewControllers([viewController], animated:true)
//        self.navigationController?.pushViewController(viewController, animated: false)
//    }
//    @IBAction func prevousQuestion(_ sender: Any) {
//        _ = navigationController?.popViewController(animated: true)
//    }
//}
