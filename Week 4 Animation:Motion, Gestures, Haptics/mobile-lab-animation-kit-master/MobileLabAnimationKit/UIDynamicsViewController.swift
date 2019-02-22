//
//  UIDynamicsViewController.swift
//  MobileLabAnimationKit
//
//  Created by Nien Lam on 2/17/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//
//  Description:
//  Example using UIDynamicAnimator.


import UIKit

class UIDynamicsViewController: UIViewController {

    // Bounding view for physics.
    @IBOutlet weak var boundingView: UIView!

    // Views for interaction.
    var blueBoxView: UIView?
    var redBoxView: UIView?
    
    // Objects required for UIDynamicAnimator.
    var animator: UIDynamicAnimator?
    var attachment: UIAttachmentBehavior?

    // Point for tracking touch.
    var currentLocation: CGPoint?

    // Custom colors.
    let blueColor = UIColor(red:0.00, green:0.62, blue:0.86, alpha:1.0)
    let redColor = UIColor(red:0.88, green:0.23, blue:0.24, alpha:1.0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
     // Set UIDynamic animators when the view appears.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Setup and add blue box.
        blueBoxView = UIView(frame: CGRect(x: 10, y: 20, width: 80, height: 80))
        blueBoxView?.backgroundColor = blueColor
        self.boundingView.insertSubview(blueBoxView!, at: 0)

        // Setup and add red box.
        redBoxView = UIView(frame: CGRect(x: 150, y: 20, width: 60, height: 60))
        redBoxView?.backgroundColor = redColor
        self.boundingView.insertSubview(redBoxView!, at: 0)
        

        // UIDynamicAnimator Setup /////

        // Setup animator object using bounding view.
        animator = UIDynamicAnimator(referenceView: self.boundingView)
        
        // Setup gravity.
        let gravity = UIGravityBehavior(items: [blueBoxView!, redBoxView!])
        let vector = CGVector(dx: 0.0, dy: 1.0)
        gravity.gravityDirection = vector
        animator?.addBehavior(gravity)

        // Setup collision.
        let collision = UICollisionBehavior(items: [blueBoxView!, redBoxView!])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collision)
        
        // Setup elasticity.
        let behavior = UIDynamicItemBehavior(items: [blueBoxView!, redBoxView!])
        behavior.elasticity = 0.5
        animator?.addBehavior(behavior)

        // Attach boxes with string.
        let boxAttachment = UIAttachmentBehavior(item: blueBoxView!, attachedTo: redBoxView!)
        boxAttachment.frequency = 4.0
        boxAttachment.damping = 0.0
        animator?.addBehavior(boxAttachment)
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        // Remove animator behaviors.
        animator?.removeAllBehaviors()
        
        // Remove view from parent view.
        blueBoxView?.removeFromSuperview()
        redBoxView?.removeFromSuperview()
    }
    

    // Connect touch position to large blue box for dragging.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let theTouch = touches.first {
            currentLocation = theTouch.location(in: self.view)
            let offset = UIOffset.init(horizontal: 20, vertical: 20)
            attachment = UIAttachmentBehavior(item: blueBoxView!,
                                              offsetFromCenter: offset,
                                              attachedToAnchor: currentLocation!)
            animator?.addBehavior(attachment!)
        }
    }
    
    // Move attachment anchor connected to large blue box.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let theTouch = touches.first {
            currentLocation = theTouch.location(in: self.view)
            attachment?.anchorPoint = currentLocation!
        }
    }
    
    // Remove connection to large blue box.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animator?.removeBehavior(attachment!)
    }
}
