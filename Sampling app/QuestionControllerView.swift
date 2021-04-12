//
//  QuestionControllerView.swift
//  Sampling app
//
//  Created by Назарова on 22.02.2021.
//

import Foundation
import UIKit

class QuestionControllerView: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    @IBAction func nextQuestion(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       // let viewController = storyboard.instantiateViewController(identifier: "Question3") as! Question3
        //navigationController?.setViewControllers([viewController], animated:true)
        //self.navigationController?.pushViewController(viewController, animated: false)
    }
    @IBAction func openMenu(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
        //navigationController?.setViewControllers([viewController], animated:true)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}
