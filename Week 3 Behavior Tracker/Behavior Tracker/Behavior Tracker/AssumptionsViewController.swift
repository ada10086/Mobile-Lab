//
//  AssumptionsViewController.swift
//  Behavior Tracker
//
//  Created by Chuchu Jiang on 2/20/19.
//  Copyright © 2019 adajiang. All rights reserved.
//

import UIKit

var myDatabase = MyDatabase()

class AssumptionsViewController: UIViewController {
    @IBOutlet weak var costGroceriesSlider: UISlider!
    @IBOutlet weak var costGroceriesLabel: UILabel!
    @IBOutlet weak var costBuyMealSlider: UISlider!
    @IBOutlet weak var costBuyMealLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func handleCostGroceriesSlider(_ sender: UISlider) {
        costGroceriesLabel.text = String(Int(sender.value))
        myDatabase.costGroceries = Int(sender.value)
    }
    
    @IBAction func handleCostBuyMealSlider(_ sender: UISlider) {
        costBuyMealLabel.text = String(Int(sender.value))
        myDatabase.costBuyMeal = Int(sender.value)
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
