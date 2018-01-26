//
//  UpdateDeleteViewController.swift
//  favoriteQuotes
//
//  Created by user on 1/25/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class UpdateDeleteViewController: UIViewController {
    
    var delegate: ChangeDelegate?
    var quote: Quote?
    var quoteIndex: IndexPath?
    var types = ["Movie", "Book", "Speech", "TV Show", "Song"]
    
    @IBOutlet var quoteField: UITextField!
    @IBOutlet var creatorField: UITextField!
    @IBOutlet var fromField: UITextField!
    @IBOutlet var typePicker: UIPickerView!
    @IBOutlet var yearField: UITextField!
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        
        print("update pressed")
        delegate?.updateQuote(quote: quote!, indexPath: quoteIndex!)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
        print("delete pressed")
        delegate?.deleteQuote(quote: quote!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteField.text = quote?.content
        creatorField.text = quote?.creator
        if quote?.from != "" {
            fromField.text = quote?.from
        }
        typePicker.delegate = self
        typePicker.dataSource = self
        typePicker.isHidden = false
        typePicker.selectedRow(inComponent: 0)
        yearField.text = String(describing: quote?.year)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UpdateDeleteViewController: UIPickerViewDelegate {
    
}

extension UpdateDeleteViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return types[row]
    }
    
}
