//
//  Question5.swift
//  Sampling app
//
//  Created by Назарова on 24.02.2021.
//

import Foundation
import UIKit

class Question5: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
    
    var question:TableQuestion!
    let data = ["One","Two","Three","Four","Five","Six","Seven","Eight"]
 
    //@IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var tableview: ContentSizedTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        question = TableQuestion(nibName:"TableQuestion", bundle:nil)
//
//        question.view.frame = CGRect(x: 0, y: self.view.frame.height-100, width: question.tableView.bounds.width, height: question.tableView.bounds.height)
//        question.view.clipsToBounds = true
//        self.addChild(question)
//        self.view.addSubview(question.view)
        self.tableview.dataSource = self
        self.tableview.delegate = self
        tableview.sizeToFit()
        self.registerTableViewCells()
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
            cell.labelName.text = data[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell",
                                  bundle: nil)
        self.tableview.register(textFieldCell,
                                forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "Question6") as! Question6
        //navigationController?.setViewControllers([viewController], animated:true)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    @IBAction func previousQuestion(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}

