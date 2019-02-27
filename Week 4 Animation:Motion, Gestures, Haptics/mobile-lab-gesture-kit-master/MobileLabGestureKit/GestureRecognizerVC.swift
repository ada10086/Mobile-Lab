//
//  GestureRecognizerVC.swift
//  MobileLabGestureKit
//
//  Created by Nien Lam on 2/17/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//

import UIKit

class GestureRecognizerVC: UIViewController {

    // View for gesture recognizers.
    var squareView: UIView!

    // Generator for haptic feedback.
    var feedbackGenerator: UIImpactFeedbackGenerator!
    
    // Toggle for changing color.
    var isViewBlue = false

    // Custom colors.
    let redColor = UIColor(red:0.88, green:0.23, blue:0.24, alpha:1.0)
    let blueColor = UIColor(red:0.00, green:0.62, blue:0.86, alpha:1.0)


    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup square view.
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        squareView.backgroundColor = redColor
        squareView.center = self.view.center
        self.view.addSubview(squareView)

        // Setup feedback generator.
        feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        
        // Create and add tap gesture recognizer to square view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        squareView.addGestureRecognizer(tap)

        // Create and add pan gesture recognizer to square view.
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        squareView.addGestureRecognizer(pan)
        
        // Create and add rotation gesture recognizer to square view.
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate))
        squareView.addGestureRecognizer(rotate)
        
        // Create and add pinch gesture recognizer to square view.
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        squareView.addGestureRecognizer(pinch)
    }
    

    // Toggle view background color and give haptic feedback on tap.
    @objc
    func handleTap(recognizer: UIPanGestureRecognizer) {
        if let view = recognizer.view {
            isViewBlue = !isViewBlue
            view.backgroundColor = isViewBlue ? blueColor : redColor

            feedbackGenerator.impactOccurred()
        }
    }
    
    // Translate view based on pan gesture.
    @objc
    func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)

        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    // Scale view using pinch.
    @objc
    func handlePinch(recognizer : UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    // Rotate view based
    @objc
    func handleRotate(recognizer : UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
}

