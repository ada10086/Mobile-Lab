//
//  ViewController.swift
//  Lock Screen
//
//  Created by Chuchu Jiang on 2/13/19.
//  Copyright © 2019 adajiang. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    // Outlet for status label.
    @IBOutlet weak var statusLabel: UILabel!
    // Outlets for image views to provide visual feedback.
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var c8Button: UIButton!
    @IBOutlet weak var myButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    var player: AVAudioPlayer?

    // UNLOCK SEQEUNCE.
    // Used to compare to input pattern.
    let lockPattern = [1, 3, 5, 7, 2, 4, 6, 8]
    /////////////////////////////////
    
    // Array to capture input from button taps.
    var inputPattern = [Int]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cButton.layer.borderColor = UIColor.black.cgColor
        cButton.layer.borderWidth = 1.0
        cButton.layer.backgroundColor = UIColor.white.cgColor
        dButton.layer.borderColor = UIColor.black.cgColor
        dButton.layer.borderWidth = 1.0
        dButton.layer.backgroundColor = UIColor.white.cgColor
        eButton.layer.borderColor = UIColor.black.cgColor
        eButton.layer.borderWidth = 1.0
        eButton.layer.backgroundColor = UIColor.white.cgColor
        fButton.layer.borderColor = UIColor.black.cgColor
        fButton.layer.borderWidth = 1.0
        fButton.layer.backgroundColor = UIColor.white.cgColor
        gButton.layer.borderColor = UIColor.black.cgColor
        gButton.layer.borderWidth = 1.0
        gButton.layer.backgroundColor = UIColor.white.cgColor
        aButton.layer.borderColor = UIColor.black.cgColor
        aButton.layer.borderWidth = 1.0
        aButton.layer.backgroundColor = UIColor.white.cgColor
        bButton.layer.borderColor = UIColor.black.cgColor
        bButton.layer.borderWidth = 1.0
        bButton.layer.backgroundColor = UIColor.white.cgColor
        c8Button.layer.borderColor = UIColor.black.cgColor
        c8Button.layer.borderWidth = 1.0
        c8Button.layer.backgroundColor = UIColor.white.cgColor
        myButton.layer.borderColor = UIColor.black.cgColor
        myButton.layer.borderWidth = 1.0
        // Reset screen on app start.
        resetScreen()
    }

    // Helper method to reset the screen.
    func resetScreen() {
        // Initialize status label.
        statusLabel.text = "Play notes to unlock"
        
        // Reset button is initially hidden.
//        resetButton.isHidden = true
        
        // Flush input pattern.
        inputPattern.removeAll()
    }
    
    // Callback methods for button presses.

    
    @IBAction func handleCButton(_ sender: UIButton) {
        processInputPattern(inputNumber: 1)
        playSoundM4a(filename:"C")
        cButton.layer.backgroundColor = UIColor.gray.cgColor
    }
    @IBAction func releaseCButton(_ sender: UIButton) {
        cButton.layer.backgroundColor = UIColor.white.cgColor
    }
    
    @IBAction func handleDButton(_ sender: UIButton) {
        processInputPattern(inputNumber: 2)
        playSoundM4a(filename:"D")
        dButton.layer.backgroundColor = UIColor.gray.cgColor
    }
    @IBAction func releaseDButton(_ sender: UIButton) {
        dButton.layer.backgroundColor = UIColor.white.cgColor
    }
    
    @IBAction func handleEButton(_ sender: UIButton) {
        processInputPattern(inputNumber: 3)
        playSoundM4a(filename:"E")
        eButton.layer.backgroundColor = UIColor.gray.cgColor
    }
    @IBAction func releaseEButton(_ sender: UIButton) {
        eButton.layer.backgroundColor = UIColor.white.cgColor
    }
    
    @IBAction func handleFButton(_ sender: Any) {
        processInputPattern(inputNumber: 4)
        playSoundM4a(filename:"F")
        fButton.layer.backgroundColor = UIColor.gray.cgColor
    }
    @IBAction func releaseFButton(_ sender: UIButton) {
        fButton.layer.backgroundColor = UIColor.white.cgColor
    }
    
    @IBAction func handleGButton(_ sender: UIButton) {
        processInputPattern(inputNumber: 5)
        playSoundM4a(filename:"G")
        gButton.layer.backgroundColor = UIColor.gray.cgColor
    }
    @IBAction func releaseGButton(_ sender: UIButton) {
        gButton.layer.backgroundColor = UIColor.white.cgColor
    }
    
    @IBAction func handleAButton(_ sender: UIButton) {
        processInputPattern(inputNumber: 6)
        playSoundM4a(filename:"A")
        aButton.layer.backgroundColor = UIColor.gray.cgColor
    }
    @IBAction func releaseAButton(_ sender: UIButton) {
        aButton.layer.backgroundColor = UIColor.white.cgColor
    }
    
    @IBAction func handleBButton(_ sender: UIButton) {
        processInputPattern(inputNumber: 7)
        playSoundM4a(filename:"B")
        bButton.layer.backgroundColor = UIColor.gray.cgColor
    }
    @IBAction func releaseBButton(_ sender: UIButton) {
        bButton.layer.backgroundColor = UIColor.white.cgColor
    }
    
    @IBAction func handleC8Button(_ sender: UIButton) {
        processInputPattern(inputNumber: 8)
        playSoundM4a(filename:"C8")
        c8Button.layer.backgroundColor = UIColor.gray.cgColor
    }
    @IBAction func releaseC8Button(_ sender: UIButton) {
        c8Button.layer.backgroundColor = UIColor.white.cgColor
    }
    
    @IBAction func handleResetButton(_ sender: UIButton) {
        resetScreen()
    }
    
    // Logic for different stages of the input sequence.
    func processInputPattern(inputNumber: Int) {
        
        // Append passed in inputNumber into input pattern array.
        inputPattern.append(inputNumber)
        
        // Check where we are in the sequence by inspecting array count.
        if inputPattern.count == 8 {
            
            // Check if pattern matches or need to try again.
            if inputPattern == lockPattern {
                
                // Update status message.
                statusLabel.text = "Unlocked"
                //doesn't play
                playSoundM4a(filename:"unlocked")

                // Reveal reset button.
//                resetButton.isHidden = false
            } else {
                // Update status message.
                statusLabel.text = "Try Again"
                
                // Flush input pattern.
                inputPattern.removeAll()
            }
        }
    }
    
    
    // Play a mp3 sound file.
    func playSoundM4a(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "m4a") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)), mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
    return input.rawValue
}

