//
//  ViewWelcome.swift
//  Sampling app
//
//  Created by Назарова on 12.04.2021.
//

import UIKit

class ViewWelcome: UIViewController {
    @IBOutlet weak var buttonBegin: CustomButtonBase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HelpFunction.setReturn(val: false)
        setUserDefualts()
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPress(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
       
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func setUserDefualts(){
        let count: [Int] = [3,3,8,1,3, 3]
        var j=0
        for i in 0..<5{
            for num in 0..<count[i]{
                if i==0 || i==3{
                                       UserDefaults.standard.setValue("-9999", forKey: String(i+1)+"_")
                                   }
                                   else{
                                       UserDefaults.standard.setValue("-9999", forKey: String(i+1)+"_"+String(num))
               
                                   }
            }
            j+=1
        }
       
    }
//            for c in count{
//                for num in 0..<c{
//                    print(i, c)
//                    if i==0 || i==3{
//                        UserDefaults.standard.setValue("-9999", forKey: String(i+1)+"_")
//                    }
//                    else{
//                        UserDefaults.standard.setValue("-9999", forKey: String(i+1)+"_"+String(num))
//
//                    }
//                    }
//                }

       // print( UserDefaults.standard.dictionaryRepresentation())
        
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


