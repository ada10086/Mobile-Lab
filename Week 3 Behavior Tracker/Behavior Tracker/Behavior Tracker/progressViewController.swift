//
//  progressViewController.swift
//  Behavior Tracker
//
//  Created by Chuchu Jiang on 2/20/19.
//  Copyright © 2019 adajiang. All rights reserved.
//

import UIKit

class progressViewController: UIViewController {
    @IBOutlet weak var savedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        savedLabel.text = String(myDatabase.saved)
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