//
//  AddViewController.swift
//  favoriteQuotes
//
//  Created by user on 1/25/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    var types = ["Movie", "Book", "Speech", "TV Show", "Song"]
    var delegate: AddViewControllerDelegate?
    
    @IBOutlet var typePicker: UIPickerView!
    @IBOutlet var contentField: UITextField!
    @IBOutlet var creatorField: UITextField!
    @IBOutlet var fromField: UITextField!
    @IBOutlet var yearField: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
    
        if contentField.text != "" && creatorField.text != "" && yearField.text != "" {
            if let year = Int16(yearField.text!) {
                
                print(contentField.text, creatorField.text, fromField.text, year, types[typePicker.selectedRow(inComponent: 0)])
                delegate?.addQuote(content: contentField.text!, creator: creatorField.text!, type: types[typePicker.selectedRow(inComponent: 0)], from: fromField.text!, year: year)
            }
            else {
                return
            }
        }
        else {
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        typePicker.delegate = self
        typePicker.dataSource = self
        typePicker.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }
}
