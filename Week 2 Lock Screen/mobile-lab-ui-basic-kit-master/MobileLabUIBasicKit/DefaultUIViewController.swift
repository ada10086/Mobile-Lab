//
//  DefaultUIViewController.swift
//  MobileLabUIKit
//
//  Created by Nien Lam on 12/4/17.
//  Copyright © 2017 Mobile Lab. All rights reserved.
//
//  Description:
//  View controller for default UI elements.

import UIKit

class DefaultUIViewController: UIViewController, UITextFieldDelegate {

    // Outlets connected to UI elements within Interface Builder.
    @IBOutlet weak var buttonOutputLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!

    @IBOutlet weak var textfieldOutputLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    
    @IBOutlet weak var sliderOutputLabel: UILabel!
    @IBOutlet weak var mySlider: UISlider!

    @IBOutlet weak var switchOutputLabel: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    
    // Class variable for tracking button taps.
    var counter = 0;

    // View initialization and setup method.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Required for textfield delegate methods.
        myTextField.delegate = self
    }

    // Increment counter on button press.
    // Update output label.
    @IBAction func handleButton(_ sender: UIButton) {
        counter = counter + 1
        buttonOutputLabel.text = "Button: \(counter)"
    }

    // Update output label with input from text field when "Done" is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfieldOutputLabel.text = "Text: \(textField.text!)"
        
        // Dismisses keyboard when done is pressed.
        view.endEditing(true)
        return false
    }
    
    // Get slider value and update output label.
    @IBAction func handleSlider(_ sender: UISlider) {
        let sliderValue = Int(sender.value)
        sliderOutputLabel.text = "Slider: \(sliderValue)"
    }
    
    // Update output label text with toggle state.
    @IBAction func handleSwitch(_ sender: UISwitch) {
        if sender.isOn {
            switchOutputLabel.text = "Switch: On"
        } else {
            switchOutputLabel.text = "Switch: Off"
        }
    }
}
