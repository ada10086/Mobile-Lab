//
//  SportUIViewController.swift
//  MobileLabUIKit
//
//  Created by Nien Lam on 12/14/17.
//  Copyright © 2017 Mobile Lab. All rights reserved.
//
//  Description:
//  View controller Sport UI theme.

import UIKit

class SportUIViewController: UIViewController {

    @IBOutlet weak var displayTimeLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!

    // Variable for tracking start time.
    var startTime = TimeInterval()

    // Timer object for scheduling stop watch time update.
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set start button toggle states.
        startStopButton.setTitle("STOP", for: .selected)
        startStopButton.setTitle("START", for: .normal)
    }
    
    @IBAction func handleStartButton(_ sender: UIButton) {
        // Toggle button state.
        startStopButton.isSelected = !startStopButton.isSelected

        if (!startStopButton.isSelected) {
            // Save current time elapsed and stop timer.
            startTime = Date().timeIntervalSinceReferenceDate - startTime
            timer.invalidate()
        }
        else if (!timer.isValid) {
            // Start timer loop with current start time.
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self,
                                         selector: #selector(updateTime),
                                         userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate - startTime
        }
    }
    
    // Reset timer and timer display.
    @IBAction func handleResetButton(_ sender: UIButton) {
        timer.invalidate()
        startTime = 0
        displayTimeLabel.text = "00:00:00"
    }
    
    // Update function called repeatedly in timer loop.
    @objc
    func updateTime() {
        let currentTime = Date().timeIntervalSinceReferenceDate
        
        // Find the difference between current time and start time.
        var elapsedTime: TimeInterval = currentTime - startTime
        
        // Calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        // Calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        // Find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        // Add the leading zero for minutes, seconds and millseconds and store them as string constants.
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        // Output formatted time.
        displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
    }
}
