//
//  EditItemViewController.swift
//  App
//
//  Created by Sydney Schiller on 11/26/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController {
    
    @IBOutlet weak var expDateTextField: UITextField!
    @IBOutlet weak var itemNameTextField: UITextField!
    
    var product = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        itemNameTextField.text = product.productName
        // create a date picker
        let datePicker = UIDatePicker()
        // set date picker mode to date
        datePicker.datePickerMode = UIDatePicker.Mode.date
        // when the value is changed in the date picker, the datePickerValueChanged
        // function is called
        datePicker.addTarget(self, action: #selector(EditItemViewController.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        // instead of a keyboard appearing, show a date picker
        expDateTextField.inputView = datePicker
        // Do any additional setup after loading the view.
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        
        let formatter = DateFormatter()
        
        //show only date, not time
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        
        //show chosen date in text field
        expDateTextField.text = formatter.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //Save Items when done
    
    
}
