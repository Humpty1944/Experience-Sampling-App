////
////  Question6.swift
////  Sampling app
////
////  Created by Назарова on 26.02.2021.
////
//
//import Foundation
//import UIKit
//
//class Question6: UIViewController{
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//    @IBAction func previousQuestion(_ sender: Any) {
//        _ = navigationController?.popViewController(animated: true)
//    }
//    
//    @IBAction func ensSession(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
//        //navigationController?.setViewControllers([viewController], animated:true)
//        self.navigationController?.pushViewController(viewController, animated: false)
//    }
//}
