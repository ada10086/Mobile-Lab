//
//  AnimationLoopViewController.swift
//  MobileLabAnimationKit
//
//  Created by Nien Lam on 2/14/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//
//  Description:
//  Using the screen redraw loop to create animations.


import UIKit

class AnimationLoopViewController: UIViewController, UIGestureRecognizerDelegate {

    // UIView to animate.
    var scaleView: UIView!
    
    // Variable for tracking current scale.
    var currentScale: CGFloat = 1.0;
    
    // Flag for tracking of scaling up or down.
    var shouldScaleUp = false

    // Speed for scaling.
    let scaleSpeed: CGFloat = 0.15

    // For view sizing.
    let viewRadius: CGFloat = 25.0

    // Custom purple color.
    let purpleColor = UIColor(red:0.59, green:0.24, blue:0.59, alpha:1.0)


    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Create scale view and make it a circle.
        scaleView = UIView(frame: CGRect(x: 0, y: 0, width: viewRadius * 2, height: viewRadius * 2))
        scaleView.layer.cornerRadius = viewRadius
        
        // Set background color.
        scaleView.backgroundColor = purpleColor

        // Center on parent view.
        scaleView.center = self.view.center

        // Add to parent view.
        self.view.addSubview(scaleView)
        
        // Setup an the update loop.
        let displayLink = CADisplayLink(target: self, selector: #selector(updateLoop))
        displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
    }
    
    @objc
    func updateLoop() {
        // Determine if scalingup or down based on flag.
        let value = shouldScaleUp ? scaleSpeed : -scaleSpeed
        
        // Scale up or down view.
        // Keep scale above 1.0 and 5.0
        currentScale = max(currentScale + value, 1.0)
        currentScale = min(currentScale, 5.0)
        
        // Scale view.
        scaleView.transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
    }

    // Set flag to true on screen press.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shouldScaleUp = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    // Set flag to false on screen release.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        shouldScaleUp = false
    }
}
