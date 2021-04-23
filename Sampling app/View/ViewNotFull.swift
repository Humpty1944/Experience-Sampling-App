//
//  ViewNotFull.swift
//  Sampling app
//
//  Created by Назарова on 12.04.2021.
//

import UIKit

class ViewNotFull: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        HelpFunction.getForgetQuestions()
        HelpFunction.setReturn(val: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
        HelpFunction.setPos(val:0)
        viewController.questionNumber=HelpFunction.getNextForgetQuestionNumber()
       
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
       
            self.navigationController?.pushViewController(viewController, animated: true)
                }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
