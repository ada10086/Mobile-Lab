//
//  Page2ViewController.swift
//  MobileLabAnimationKit
//
//  Created by Nien Lam on 2/14/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//
//  Description:
//  Example of using timing curves.


import UIKit

class TimingCurvesViewController: UIViewController {

    // Create image views with running image.
    let linearCurveImageView = UIImageView(image: UIImage(named:"running.png"))
    let easeInCurveImageView = UIImageView(image: UIImage(named:"running.png"))
    let easeOutCurveImageView = UIImageView(image: UIImage(named:"running.png"))
    let easeInOutCurveImageView = UIImageView(image: UIImage(named:"running.png"))
    let springCurveImageView = UIImageView(image: UIImage(named:"running.png"))

    // Proportion value for image view size.
    let sizeProportion: CGFloat = 0.15
    
    // Animation duration.
    let duration: Double = 2.0

    // Image view size.
    var imageViewSize: CGFloat!


    // Setup image views and labels and add to parent on initial setup.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Make image view sizes a percentage of the overall view width.
        imageViewSize = self.view.frame.width * sizeProportion
        
        // Start y alignment from the top.
        var yOffset: CGFloat = imageViewSize * 1.9;
        
        // ------------------------------------------------------------------------------------------

        // Setup image view for linear curve animation.
        linearCurveImageView.frame = CGRect(x: 0, y: 0, width: imageViewSize, height: imageViewSize)
        linearCurveImageView.center = CGPoint(x: imageViewSize / 2.0, y: yOffset)
        linearCurveImageView.contentMode = .scaleAspectFit
        self.view.addSubview(linearCurveImageView)

        // Create, position and add label.
        let linearLabel = UILabel(frame: CGRect(x: 20.0, y: yOffset + imageViewSize / 2, width: 200.0, height: 30.0))
        linearLabel.text = "Linear Curve"
        self.view.addSubview(linearLabel)

        // Move y alignment down.
        yOffset += imageViewSize * 1.9;

        // ------------------------------------------------------------------------------------------

        // Setup image view for easeIn curve animation.
        easeInCurveImageView.frame = CGRect(x: 0, y: 0, width: imageViewSize, height: imageViewSize)
        easeInCurveImageView.center = CGPoint(x: imageViewSize / 2.0, y: yOffset)
        easeInCurveImageView.contentMode = .scaleAspectFit
        self.view.addSubview(easeInCurveImageView)
        
        // Create, position and add label.
        let easeInLabel = UILabel(frame: CGRect(x: 20.0, y: yOffset + imageViewSize / 2, width: 200.0, height: 30.0))
        easeInLabel.text = "EaseIn Curve"
        self.view.addSubview(easeInLabel)
        
        // Move y alignment down.
        yOffset += imageViewSize * 1.9;

        // ------------------------------------------------------------------------------------------
        
        // Setup image view for easeOut curve animation.
        easeOutCurveImageView.frame = CGRect(x: 0, y: 0, width: imageViewSize, height: imageViewSize)
        easeOutCurveImageView.center = CGPoint(x: imageViewSize / 2.0, y: yOffset)
        easeOutCurveImageView.contentMode = .scaleAspectFit
        self.view.addSubview(easeOutCurveImageView)
        
        // Create, position and add label.
        let easeOutLabel = UILabel(frame: CGRect(x: 20.0, y: yOffset + imageViewSize / 2, width: 200.0, height: 30.0))
        easeOutLabel.text = "EaseOut Curve"
        self.view.addSubview(easeOutLabel)
        
        // Move y alignment down.
        yOffset += imageViewSize * 1.9;

        // ------------------------------------------------------------------------------------------
        
        // Setup image view for easeInOut curve animation.
        easeInOutCurveImageView.frame = CGRect(x: 0, y: 0, width: imageViewSize, height: imageViewSize)
        easeInOutCurveImageView.center = CGPoint(x: imageViewSize / 2.0, y: yOffset)
        easeInOutCurveImageView.contentMode = .scaleAspectFit
        self.view.addSubview(easeInOutCurveImageView)
        
        // Create, position and add label.
        let easeInOutLabel = UILabel(frame: CGRect(x: 20.0, y: yOffset + imageViewSize / 2, width: 200.0, height: 30.0))
        easeInOutLabel.text = "EaseInOut Curve"
        self.view.addSubview(easeInOutLabel)
        
        // Move y alignment down.
        yOffset += imageViewSize * 1.9;

        // ------------------------------------------------------------------------------------------
        
        // Setup image view for spring curve animation.
        springCurveImageView.frame = CGRect(x: 0, y: 0, width: imageViewSize, height: imageViewSize)
        springCurveImageView.center = CGPoint(x: imageViewSize / 2.0, y: yOffset)
        springCurveImageView.contentMode = .scaleAspectFit
        self.view.addSubview(springCurveImageView)
        
        // Create, position and add label.
        let springLabel = UILabel(frame: CGRect(x: 20.0, y: yOffset + imageViewSize / 2, width: 200.0, height: 30.0))
        springLabel.text = "Spring"
        self.view.addSubview(springLabel)
    }

    
    // Helper method to reset view positions.
    func resetViews() {
        linearCurveImageView.center = CGPoint(x: imageViewSize / 2.0, y: self.linearCurveImageView.center.y)
        easeInCurveImageView.center = CGPoint(x: imageViewSize / 2.0, y: self.easeInCurveImageView.center.y)
        easeOutCurveImageView.center = CGPoint(x: imageViewSize / 2.0, y: self.easeOutCurveImageView.center.y)
        easeInOutCurveImageView.center = CGPoint(x: imageViewSize / 2.0, y: self.easeInOutCurveImageView.center.y)
        springCurveImageView.center = CGPoint(x: imageViewSize / 2.0, y: self.springCurveImageView.center.y)
    }
    

    // Set animations when the view appears.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set view positions to left side of the screen.
        resetViews()
        
        // Set x target to right side of the screen.
        let xTarget = self.view.frame.width - self.imageViewSize / 2.0
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveLinear, .repeat],
            animations: {
                self.linearCurveImageView.center = CGPoint(x: xTarget, y: self.linearCurveImageView.center.y)
            })

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveEaseIn, .repeat],
            animations: {
                self.easeInCurveImageView.center = CGPoint(x: xTarget, y: self.easeInCurveImageView.center.y)
            })

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveEaseOut, .repeat],
            animations: {
                self.easeOutCurveImageView.center = CGPoint(x: xTarget, y: self.easeOutCurveImageView.center.y)
            })

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveEaseInOut, .repeat],
            animations: {
                self.easeInOutCurveImageView.center = CGPoint(x: xTarget, y: self.easeInOutCurveImageView.center.y)
            })

        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 0.30,
            initialSpringVelocity: 0.0,
            options: [.curveEaseInOut, .repeat],
            animations: {
                self.springCurveImageView.center = CGPoint(x: xTarget, y: self.springCurveImageView.center.y)
            })
 
    }
    
    
    // Remove animations when the view disappears.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Remove all animations.
        for view in view.subviews {
            view.layer.removeAllAnimations()
        }
    }
    
    
}
