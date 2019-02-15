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
//        cButton.layer.cornerRadius = 4.0
        dButton.layer.borderColor = UIColor.black.cgColor
        dButton.layer.borderWidth = 1.0
        eButton.layer.borderColor = UIColor.black.cgColor
        eButton.layer.borderWidth = 1.0
        fButton.layer.borderColor = UIColor.black.cgColor
        fButton.layer.borderWidth = 1.0
        gButton.layer.borderColor = UIColor.black.cgColor
        gButton.layer.borderWidth = 1.0
        aButton.layer.borderColor = UIColor.black.cgColor
        aButton.layer.borderWidth = 1.0
        bButton.layer.borderColor = UIColor.black.cgColor
        bButton.layer.borderWidth = 1.0
        c8Button.layer.borderColor = UIColor.black.cgColor
        c8Button.layer.borderWidth = 1.0
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

    @IBAction func handleButtonC(_ sender: UIButton) {
        // Process current pattern with input 1.
        processInputPattern(inputNumber: 1)
        playSoundM4a(filename:"C")
        //wouldn't change back to white
        cButton.layer.backgroundColor = UIColor.gray.cgColor
    }
    
    @IBAction func handleButtonD(_ sender: UIButton) {
        processInputPattern(inputNumber: 2)
        playSoundM4a(filename:"D")
    }
    
    @IBAction func handleButtonE(_ sender: UIButton) {
        processInputPattern(inputNumber: 3)
        playSoundM4a(filename:"E")
    }
    
    @IBAction func handleButtonF(_ sender: UIButton) {
        processInputPattern(inputNumber: 4)
        playSoundM4a(filename:"F")
    }
    
    @IBAction func handleButtonG(_ sender: UIButton) {
        processInputPattern(inputNumber: 5)
        playSoundM4a(filename:"G")
    }
    
    @IBAction func handleButtonA(_ sender: UIButton) {
        processInputPattern(inputNumber: 6)
        playSoundM4a(filename:"A")
    }
    
    @IBAction func handleButtonB(_ sender: UIButton) {
        processInputPattern(inputNumber: 7)
        playSoundM4a(filename:"B")
    }
    
    @IBAction func handleButtonC8(_ sender: UIButton) {
        processInputPattern(inputNumber: 8)
        playSoundM4a(filename:"C8")
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

