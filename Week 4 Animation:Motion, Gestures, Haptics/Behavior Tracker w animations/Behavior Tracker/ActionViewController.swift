//
//  ActionViewController.swift
//  Behavior Tracker
//
//  Created by Chuchu Jiang on 2/19/19.
//  Copyright © 2019 adajiang. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var mealTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    var myImageURL: URL?

    // Callback method to be defined in parent view controller.
    var didSaveMeal: ((_ meal: Meal) -> ())?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add picker view
        createPickerView()
        dismissPickerView()
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.addTarget(self, action: #selector(ActionViewController.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        dateTextField.inputView = datePicker
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = formatter.string(from: sender.date)
    }
    
    
    //import image button to import image from camera roll, need to add privacy -photo library usage in info.plist
    @IBAction func handleImportImage(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.myImageView.image = image
        self.myImageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func handleSaveButton(_ sender: UIButton) {
        if typeTextField.text == "Own Meal" {
            myDatabase.savedPerMeal = myDatabase.costBuyMeal - myDatabase.costGroceries/21
            myDatabase.saved += myDatabase.savedPerMeal
        }
        /*
        guard let date = dateTextField.text,
            let bld = mealTextField.text,
            let type = typeTextField.text
        else { return }
        */

        // Pass back data. save imageURL, date, bld, type, add to array
        let meal = Meal(
                        imageURL: self.myImageURL,
                        date: dateTextField.text ?? "",
                        bld: mealTextField.text ?? "",
                        type: typeTextField.text ?? "")
        didSaveMeal?(meal)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func handleCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //doesnt dismiss???no done button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismisses keyboard when done is pressed.
        view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
    var priorityTypes = ["Own Meal", "Bought Meal"]
    
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


