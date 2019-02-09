//
//  ViewController.swift
//  MobileLab1ButtonKit
//
//  Created by Nien Lam on 1/19/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//
//  Description:
//  View controller creating a one button application.

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // EDIT START ////////////////////////////////////////////////////////////////////////////////////////
    
    // Set to 'true' or 'false' to control content sequence.
    // Either flip through content in sequence or randomize.
    let randomize = false
    
    // Set to array size.
    // Make sure all arrays are the same length and matches array size.
    let arraySize = 7
    
    // Background array.
    let bgColorArray = [UIColor(hex: 0xFFFFFF),
                        UIColor(hex: 0xFFFFFF),
                        UIColor(hex: 0xFFFFFF),
                        UIColor(hex: 0xFFFFFF),
                        UIColor(hex: 0xFFFFFF),
                        UIColor(hex: 0xFFFFFF),
                        UIColor(hex: 0xFFFFFF)]
    
    // Image name array.
    // Set to image name or set to empty string.
    let imageNameArray = ["lineup.jpg",
                          "Darker Than Wax.jpg",
                          "FaltyDL.PNG",
                          "Baltra.PNG",
                          "Justin Strauss.jpg",
                          "Eli Escobar.PNG",
                          "Lisas b2b Dave P.jpg"]
    
    // String array for label.
    // Set text or set to empty string.
    let stringArray = ["",
                       "Darker Than Wax",
                       "FaltyDL",
                       "Baltra",
                       "Justin Strauss",
                       "Eli Escobar",
                       "Lisas b2b Dave P"]
    
    // MP3 sound file array.
    // Set mp3 file name or set to empty string.
    let soundArray = ["",
                      "",
                      "",
                      "",
                      "",
                      "",
                      ""]
    
    // EDIT END //////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////

    
    // Connected to storyboard UI elements.
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var player: AVAudioPlayer?

    var currentIndex = -1

    
    // Initial setup function.
    override func viewDidLoad() {
        super.viewDidLoad()

        updateContent()
        playSoundMP3(filename:"Justin Strauss")
    }

    // Called when screen is tapped.
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        generateImpactFeedback()

        updateContent()
    }

    
    // Update content based on array content and current array index.
    func updateContent() {
        // Update content index.,
        nextIndex()

        // Update background color.
        view.backgroundColor = bgColorArray[currentIndex]

        // Update label.
        label.text = stringArray[currentIndex]

        // Update image if string is not empty
        if imageNameArray[currentIndex].isEmpty {
            imageView.image = nil
        } else {
            imageView.image = UIImage(named: imageNameArray[currentIndex])
        }

        // Play sound.
        if !soundArray[currentIndex].isEmpty {
            playSoundMP3(filename: soundArray[currentIndex])
        }
    }

    
    // Either increment index or randomize.
    func nextIndex() {
        if randomize {
            currentIndex = Int(arc4random_uniform(UInt32(arraySize)))
        } else {
            currentIndex = (currentIndex + 1 == arraySize) ? 0 : currentIndex + 1
        }
    }

    // Make the device vibrate.
    func generateImpactFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }

    // Play a mp3 sound file.
    func playSoundMP3(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else { return }
        
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
