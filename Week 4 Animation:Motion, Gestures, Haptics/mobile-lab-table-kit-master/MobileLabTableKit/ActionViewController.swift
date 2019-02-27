//
//  ActionViewController.swift
//  MobileLabTableKit
//
//  Created by Nien Lam on 4/13/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
