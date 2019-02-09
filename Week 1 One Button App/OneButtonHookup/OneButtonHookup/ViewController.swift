//
//  ViewController.swift
//  OneButtonHookup
//
//  Created by Chuchu Jiang on 2/6/19.
//  Copyright © 2019 adajiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        myButton.backgroundColor = UIColor.red
//        myButton.setTitle("Don't press me",for:.normal)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func handleButton(_ sender: UIButton) {
        myButton.backgroundColor = UIColor.red
        myButton.setTitle("Don't press me",for:.normal)
    }
    
}

