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
    //create shape layer - progress bar %
    let shapeLayer = CAShapeLayer()
    //create track layer - track bar 100 %
    let trackLayer = CAShapeLayer()
    //create pulsating layer
    var pulsatingLayer: CAShapeLayer!
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "hi"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize:32)
        return label
    }()
    
//    private func setupNotificationObservers(){
//        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground),
//                                               name: .UIApplication.willEnterForegroundNotification, object: nil)
//    }
//    @objc private func handleEnterForeground(){
//        animatePulsatingLayer()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupNotificationObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let percentage  = CGFloat(myDatabase.saved)/CGFloat(myDatabase.savingGoal)
        savedLabel.text = String(myDatabase.saved)
        goalLabel.text = String(myDatabase.savingGoal)
        
        //let center = view.center
    
        //create circular path
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
       
        let pulsatingLayerColor = UIColor(red: 232.0/255.0, green: 240.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.strokeColor = pulsatingLayerColor.cgColor
        pulsatingLayer.lineWidth = 15
        pulsatingLayer.fillColor = pulsatingLayerColor.cgColor
        pulsatingLayer.position = view.center
        view.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
        
        let trackLayerColor = UIColor(red: 208.0/255.0, green: 216.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = trackLayerColor.cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.white.cgColor
        trackLayer.position = view.center
        view.layer.addSublayer(trackLayer)
        
        let shapeLayerColor = UIColor(red: 156.0/255.0, green: 193.0/255.0, blue: 252.0/255.0, alpha: 1.0)
        shapeLayer.path = circularPath.cgPath
        view.layer.addSublayer(shapeLayer)
        shapeLayer.strokeColor = shapeLayerColor.cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round // rounded ends
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
        
        
        //percentage label
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
        percentageLabel.text = "\(Int(percentage * 100))%"
    }
    
    private func animatePulsatingLayer(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.3
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation,forKey:"pulsing")
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
