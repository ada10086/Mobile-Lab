//
//  ActionViewController.swift
//  Behavior Tracker
//
//  Created by Chuchu Jiang on 2/19/19.
//  Copyright © 2019 adajiang. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var mealTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    // Callback method to be defined in parent view controller.
    var didSaveMeal: ((_ meal: Meal) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        dismissPickerView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleSaveButton(_ sender: UIButton) {
        if typeTextField.text == "Own Food" {
            myDatabase.savedPerMeal = myDatabase.costBuyMeal - myDatabase.costGroceries/21
            myDatabase.saved += myDatabase.savedPerMeal
        }
        /*
        guard let date = dateTextField.text,
            let bld = mealTextField.text,
            let type = typeTextField.text
        else { return }
        
        
        // Pass back data.
        let meal = Meal(imageName: "",
                        date: date,
                        bld: bld,
                        type: type)
        didSaveMeal?(meal)
        */

        // Pass back data.
        let meal = Meal(imageName: "",
                        date: dateTextField.text ?? "",
                        bld: mealTextField.text ?? "",
                        type: typeTextField.text ?? "")
        didSaveMeal?(meal)
        //save date, bld, type, add to array
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func handleCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismisses keyboard when done is pressed.
        view.endEditing(true)
        return false
    }
    
    
    
    //type picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorityTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorityTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPriority = priorityTypes[row]
        typeTextField.text = selectedPriority
    }
    
    var selectedPriority: String?
    var priorityTypes = ["Own Food", "Buy Meal"]
    
    func createPickerView(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        typeTextField.inputView = pickerView
    }
    
    func dismissPickerView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([doneButton], animated:false)
        toolBar.isUserInteractionEnabled = true
        typeTextField.inputAccessoryView = toolBar

    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

}


