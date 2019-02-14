//
//  LCARSUIViewController.swift
//  MobileLabUIKit
//
//  Created by Nien Lam on 12/4/17.
//  Copyright © 2017 Mobile Lab. All rights reserved.
//
//  Description:
//  View controller for Star Trek Library Computer Access and Retrieval System (LCARS) theme.

import UIKit

class LCARSUIViewController: UIViewController {
    
    // Outlets to buttons.
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    // Outlets to cap views for header and footer.
    @IBOutlet weak var topLeftCapView: UIView!
    @IBOutlet weak var topRightCapView: UIView!
    @IBOutlet weak var bottomLeftCapView: UIView!
    @IBOutlet weak var bottomRightCapView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Round buttons.
        for button in [button1, button2, button3, button4] {
            button!.layer.cornerRadius = 22.0
        }
        
        // Round left cap views.
        for leftCapView in [topLeftCapView, bottomLeftCapView] {
            let maskPath = UIBezierPath(roundedRect: leftCapView!.bounds,
                                        byRoundingCorners: [.topLeft, .bottomLeft],
                                        cornerRadii: CGSize(width: 12, height: 12))
            let maskLayer   = CAShapeLayer()
            maskLayer.frame = leftCapView!.bounds
            maskLayer.path  = maskPath.cgPath
            leftCapView!.layer.mask = maskLayer
        }

        // Round right cap views.
        for rightCapView in [topRightCapView, bottomRightCapView] {
            let maskPath = UIBezierPath(roundedRect: rightCapView!.bounds,
                                        byRoundingCorners: [.topRight, .bottomRight],
                                        cornerRadii: CGSize(width: 12, height: 12))
            let maskLayer   = CAShapeLayer()
            maskLayer.frame = rightCapView!.bounds
            maskLayer.path  = maskPath.cgPath
            rightCapView!.layer.mask = maskLayer
        }
    }
}
