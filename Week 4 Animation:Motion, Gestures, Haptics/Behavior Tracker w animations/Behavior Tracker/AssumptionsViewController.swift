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
    @IBOutlet weak var groceriesImage: UIImageView!
    @IBOutlet weak var wasteMoneyImage: UIImageView!
    @IBOutlet weak var goal: UITextField!
    
    
    // Animation duration.
    let duration: Double = 1.0
    var scaleGroceries: Double = 1.0
    var scaleWasteMoney: Double = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make square sizes a percentage of the overall view width.
//        let groceriesImageSize = 30.0
        
//        groceriesImage = UIImageView(frame:CGRect(x:0, y:0, width:groceriesImageSize, height:groceriesImageSize))
        // Reposition view center horizontally and down from the top.
//        groceriesImage.center = CGPoint(x: xOffset, y: yOffset)
        
        // Add view to parent view.
        self.view.addSubview(groceriesImage)
        self.view.addSubview(wasteMoneyImage)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        myDatabase.savingGoal = Int(goal.text!)!
    }

    
//    // Remove animations when the view disappears.
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // Remove all animations.
//        for view in view.subviews {
//            view.layer.removeAllAnimations()
//        }
//    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func handleCostGroceriesSlider(_ sender: UISlider) {
        costGroceriesLabel.text = String(Int(sender.value))
        myDatabase.costGroceries = Int(sender.value)
//        scaleGroceries = map
        // Scale animation.
        UIView.animate(
            withDuration: 0,
            delay: 0,
            options: [.allowAnimatedContent],
            animations: {
                self.groceriesImage.transform = CGAffineTransform(scaleX: CGFloat(sender.value/100), y: CGFloat(sender.value/100))
        })
//        // Rotation animation.
//        // Need to chain two animations to complete full rotation.
//        UIView.animate(
//            withDuration: duration,
//            delay: 0,
//            options: [.curveLinear, .repeat],
//            animations: {
//                self.rotationSquareView.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi)))
//        }) { _ in
//            // Runs after animation completes.
//            UIView.animate(
//                withDuration: 0.5,
//                delay: 0,
//                options: .curveLinear,
//                animations: {
//                    self.rotationSquareView.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi * 2)))
//            })
//        }
    }

    
    @IBAction func handleCostBuyMealSlider(_ sender: UISlider) {
        costBuyMealLabel.text = String(Int(sender.value))
        myDatabase.costBuyMeal = Int(sender.value)
        //        scaleWasteMoney = map
        // Scale animation.
        UIView.animate(
            withDuration: 0,
            delay: 0,
            options: [.allowAnimatedContent],
            animations: {
                self.wasteMoneyImage.transform = CGAffineTransform(scaleX: CGFloat(sender.value/25), y: CGFloat(sender.value/25))
        })
        //        // Rotation animation.
        //        // Need to chain two animations to complete full rotation.
        //        UIView.animate(
        //            withDuration: duration,
        //            delay: 0,
        //            options: [.curveLinear, .repeat],
        //            animations: {
        //                self.rotationSquareView.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi)))
        //        }) { _ in
        //            // Runs after animation completes.
        //            UIView.animate(
        //                withDuration: 0.5,
        //                delay: 0,
        //                options: .curveLinear,
        //                animations: {
        //                    self.rotationSquareView.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi * 2)))
        //            })
        //        }
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
