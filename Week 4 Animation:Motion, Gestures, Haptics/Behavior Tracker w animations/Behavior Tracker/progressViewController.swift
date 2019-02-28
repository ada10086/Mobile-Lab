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
    @IBOutlet weak var goalLabel: UILabel!
    let shapeLayer = CAShapeLayer()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "hi"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize:32)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(percentageLabel)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let percentage  = CGFloat(myDatabase.saved)/CGFloat(myDatabase.savingGoal)
        savedLabel.text = String(myDatabase.saved)
        goalLabel.text = String(myDatabase.savingGoal)
        
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
        percentageLabel.text = "\(Int(percentage * 100))%"
        
        //drawing a circle
        
        //        let center = view.center
        
        //create track layer
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        view.layer.addSublayer(shapeLayer)
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 15
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.position = view.center
        view.layer.addSublayer(trackLayer)
        
        //create circular path
        //        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: CGFloat(myDatabase.saved/myDatabase.savingGoal) * 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        view.layer.addSublayer(shapeLayer)
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 15
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.position = view.center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        
        //animation
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = percentage
        basicAnimation.duration = 2
        //in order for animation to stay at the end
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "hi")
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
