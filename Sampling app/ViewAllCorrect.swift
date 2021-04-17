//
//  ViewAllCorrect.swift
//  Sampling app
//
//  Created by Назарова on 11.04.2021.
//

import Foundation
import UIKit
class ViewAllCorrect: UIViewController{
    
    
    @IBOutlet weak var buttonRepaetSend: CustomButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        buttonRepaetSend.isHidden=true
        buttonRepaetSend.isEnabled = false
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
            HelpFunction.deleteAll()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
           
            self.navigationController?.pushViewController(viewController, animated: true)
                }
    }
    
    func repeateSend(){
        buttonRepaetSend.isHidden=false
        buttonRepaetSend.isEnabled = true
    }
    
    @IBAction func sendAgain(_ sender: Any) {
    }
    
}
