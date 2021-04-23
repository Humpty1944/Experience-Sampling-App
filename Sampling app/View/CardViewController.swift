//
//  CardViewController.swift
//  CardViewAnimation
//
//  Created by Brian Advent on 26.10.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var rectCode: UIView!
    @IBOutlet weak var firstRect: UIView!
    @IBOutlet weak var handleArea: UIView!
    
    @IBOutlet weak var secondRect: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstRect.layer.cornerRadius=24
        secondRect.layer.cornerRadius=24
        rectCode.layer.borderWidth=1
        
        rectCode.layer.borderColor = CGColor(red: 196, green: 196, blue: 196, alpha: 1.0)
    }
}
