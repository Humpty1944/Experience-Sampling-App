//
//  TableQuestion.swift
//  Sampling app
//
//  Created by Назарова on 24.02.2021.
//

import UIKit

class TableQuestion: UIView, UITableViewDataSource, UITableViewDelegate {
    var data = ["One","Two","Three","Four","Five",]
    var tableView:UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        commonInit()
//    }
    override init(frame: CGRect) {
          super.init(frame: frame)
          commonInit()
      }
      
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          commonInit()
      }
      
      func commonInit() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.registerTableViewCells()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleCardTap(recognzier:)))
       // tableView.f
        tableView.addGestureRecognizer(tapGestureRecognizer)
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        bringSubviewToFront(tableView)
        //self.bringSubviewToFront(tableView)
          //Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
          //contentView.fixInView(self)
      }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
            cell.labelName.text = data[indexPath.row]
            cell.contentView.isUserInteractionEnabled = true
            return cell
        }
        
        return UITableViewCell()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "CustomTableViewCell")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
