//
//  UIViewAnimationsViewController.swift
//  MobileLabAnimationKit
//
//  Created by Nien Lam on 2/14/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//
//  Description:
//  Example of different UIView Animations.


import UIKit

class UIViewAnimationsViewController: UIViewController {

    // Views to be added programmatically to parent view.
    var positionSquareView: UIView!
    var scaleSquareView: UIView!
    var rotationSquareView: UIView!
    var colorSquareView: UIView!
    var opacitySquareView: UIView!

    // Proportion value for square size.
    let sizeProportion: CGFloat = 0.11

    // Animation duration.
    let duration: Double = 1.0
    
    // Custom colors.
    let redColor = UIColor(red:0.88, green:0.23, blue:0.24, alpha:1.0)
    let blueColor = UIColor(red:0.00, green:0.62, blue:0.86, alpha:1.0)

    
    // Create square views and labels and add to parent on initial setup.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Make square sizes a percentage of the overall view width.
        let squareSize = self.view.frame.width * sizeProportion
        
        // Use screen center for x offset.
        let xOffset = self.view.center.x

        // Start y offset from the top.
        var yOffset = squareSize * 2.85;

        // ------------------------------------------------------------------------------------------

        // Create sqaure view and at origin.
        positionSquareView = UIView(frame: CGRect(x: 0, y: 0, width: squareSize, height: squareSize))

        // Set view color.
        positionSquareView.backgroundColor = redColor
        
        // Reposition view center horizontally and down from the top.
        positionSquareView.center = CGPoint(x: xOffset, y: yOffset)
        
        // Add view to parent view.
        self.view.addSubview(positionSquareView)

        // Create, position and add label.
        let positionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100.0, height: 20.0))
        positionLabel.text = "Position"
        positionLabel.textAlignment = .center
        positionLabel.center = CGPoint(x: xOffset, y: yOffset + squareSize)
        self.view.addSubview(positionLabel)

        // Move y offset down.
        yOffset += squareSize * 2.5;

        // ------------------------------------------------------------------------------------------
        
        // Setup scale square view.
        scaleSquareView = UIView(frame: CGRect(x: 0, y: 0, width: squareSize, height: squareSize))
        scaleSquareView.backgroundColor = redColor
        scaleSquareView.center = CGPoint(x: xOffset, y: yOffset)
        self.view.addSubview(scaleSquareView)

        // Setup scale label.
        let scaleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100.0, height: 20.0))
        scaleLabel.text = "Scale"
        scaleLabel.textAlignment = .center
        scaleLabel.center = CGPoint(x: xOffset, y: yOffset + squareSize)
        self.view.addSubview(scaleLabel)

        // Move y offset down.
        yOffset += squareSize * 2.5;

        // ------------------------------------------------------------------------------------------

        // Setup rotation square view.
        rotationSquareView = UIView(frame: CGRect(x: 0, y: 0, width: squareSize, height: squareSize))
        rotationSquareView.backgroundColor = redColor
        rotationSquareView.center = CGPoint(x: xOffset, y: yOffset)
        self.view.addSubview(rotationSquareView)

        // Setup rotation label.
        let rotationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100.0, height: 20.0))
        rotationLabel.text = "Rotation"
        rotationLabel.textAlignment = .center
        rotationLabel.center = CGPoint(x: xOffset, y: yOffset + squareSize)
        self.view.addSubview(rotationLabel)

        // Move y offset down.
        yOffset +=  squareSize * 2.5;

        // ------------------------------------------------------------------------------------------

        // Setup color square view.
        colorSquareView = UIView(frame: CGRect(x: 0, y: 0, width: squareSize, height: squareSize))
        colorSquareView.backgroundColor = redColor
        colorSquareView.center = CGPoint(x: xOffset, y: yOffset)
        self.view.addSubview(colorSquareView)

        // Setup color label.
        let colorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100.0, height: 20.0))
        colorLabel.text = "Color"
        colorLabel.textAlignment = .center
        colorLabel.center = CGPoint(x: xOffset, y: yOffset + squareSize)
        self.view.addSubview(colorLabel)

        // Move y offset down.
        yOffset +=  squareSize * 2.5;

        // ------------------------------------------------------------------------------------------

        // Setup opacity square view.
        opacitySquareView = UIView(frame: CGRect(x: 0, y: 0, width: squareSize, height: squareSize))
        opacitySquareView.backgroundColor = redColor
        opacitySquareView.center = CGPoint(x: xOffset, y: yOffset)
        self.view.addSubview(opacitySquareView)

        // Setup opacity label.
        let opacityLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100.0, height: 20.0))
        opacityLabel.text = "Opacity"
        opacityLabel.textAlignment = .center
        opacityLabel.center = CGPoint(x: xOffset, y: yOffset + squareSize)
        self.view.addSubview(opacityLabel)
    }
    

    // Helper method to reset animation parameters for views.
    func resetViews() {
        positionSquareView.center = CGPoint(x: self.view.center.x, y: positionSquareView.center.y)
        
        scaleSquareView.transform = .identity
        
        rotationSquareView.transform = .identity
        
        colorSquareView.backgroundColor = redColor
        
        opacitySquareView.alpha = 1.0
    }
    
    
    // Set animations when the view appears.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Reset view properties.
        resetViews()

        // Position animation.
        self.positionSquareView.center = CGPoint(x: self.view.center.x - 100.0, y: self.positionSquareView.center.y)
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveLinear, .autoreverse, .repeat],
            animations: {
                self.positionSquareView.center = CGPoint(x: self.view.center.x + 100.0, y: self.positionSquareView.center.y)
            })

        // Scale animation.
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveLinear, .autoreverse, .repeat],
            animations: {
                self.scaleSquareView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            })
        
        // Rotation animation.
        // Need to chain two animations to complete full rotation.
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveLinear, .repeat],
            animations: {
                self.rotationSquareView.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi)))
            }) { _ in
                // Runs after animation completes.
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: .curveLinear,
                    animations: {
                        self.rotationSquareView.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi * 2)))
                    })
            }

        // Color animation.
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveLinear, .autoreverse, .repeat],
            animations: {
                self.colorSquareView.backgroundColor = self.blueColor
        })

        
        // Opacity animation.
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveLinear, .autoreverse, .repeat],
            animations: {
                self.opacitySquareView.alpha = 0.0
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
