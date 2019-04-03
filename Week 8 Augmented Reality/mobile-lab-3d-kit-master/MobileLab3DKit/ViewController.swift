//
//  ViewController.swift
//  MobileLab3DKit
//
//  Created by Nien Lam on 3/8/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import ARKit


// Animation states.
let Animations: [(name: String, file: String)] = [
    ("Idle",  "idle.dae"),
    ("Dancing",  "Samba Dancing.dae"),
    ("Jumping", "jumping.dae")]


class ViewController: UIViewController {

    // Outlet to scene view container.
    @IBOutlet weak var sceneView: SCNView!

    // Outlet to button for toggling different animations.
    @IBOutlet weak var animationButton: UIButton!

    // Reference to hero character node.
    var heroNode: SCNNode!

    // Reference to box node in scene node.
    var redBoxNode: SCNNode!
    
    // Structure for cycling through animation states.
    var heroAnimations = CycleArray(Animations)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a new scene.
        let scene = SCNScene(named: "art.scnassets/main_scene.scn")!

        // Set the scene to the view.
        sceneView.scene = scene
        
        // Allows the user to manipulate the camera with gestures.
        sceneView.allowsCameraControl = true
        
        // Show statistics such as fps and timing information.
        // sceneView.showsStatistics = true


        // Access hero node by name.
        heroNode = sceneView.scene!.rootNode.childNode(withName: "Olive", recursively: true)!

        // Load and add all animations to hero node.
        // Can later be access by key name for playback.
        for animation in Animations {
            let animationPlayer = SCNAnimationPlayer.loadAnimation(fromSceneNamed: "art.scnassets/animations/\(animation.file)")
            
            // Adjust animation blend duration for smooth transitions.
            animationPlayer.animation.blendInDuration = 0.25
            animationPlayer.animation.blendOutDuration  = 0.5
            animationPlayer.stop()
            
            heroNode.addAnimationPlayer(animationPlayer, forKey: animation.name)
        }

        // Play initial animation.
        heroNode.animationPlayer(forKey: heroAnimations.currentElement!.name)!.play()

        // Update button title with animation name.
        updateButtonTitle()

        
        // Access cube node by name.
        redBoxNode = sceneView.scene!.rootNode.childNode(withName: "red_box", recursively: true)!
        
        // Spin box.
        redBoxNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
    }
    
    @IBAction func handleButton(_ sender: UIButton) {
        // Get current animation and next animation.
        let currAnimation = heroAnimations.currentElement
        let nextAnimation = heroAnimations.cycle()
        
        // Stop current animation.
        heroNode.animationPlayer(forKey: currAnimation!.name)!.stop(withBlendOutDuration: 1.0)

        // Play next animation.
        heroNode.animationPlayer(forKey: nextAnimation!.name)!.play()

        // Update button title with current animation name.
        updateButtonTitle()
    }
    
    func updateButtonTitle() {
        animationButton.setTitle(heroAnimations.currentElement?.name, for: .normal)
    }

    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
}



