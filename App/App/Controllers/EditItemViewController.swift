//
//  EditItemViewController.swift
//  App
//
//  Created by Sydney Schiller on 11/26/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import UIKit
import TextFieldEffects

protocol UpdateListDelegate {
    func ListUpdate(finishedProduct: Product, isEditing: Bool)
}


class EditItemViewController: UIViewController {
    
    @IBOutlet weak var expDateTextField: UITextField!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    
    @IBOutlet weak var expiredLabel: UILabel!
    
    @IBOutlet weak var palmSwitch: UISwitch!
    @IBOutlet weak var dairySwitch: UISwitch!
    @IBOutlet weak var nutSwitch: UISwitch!
    @IBOutlet weak var wheatSwitch: UISwitch!
    @IBOutlet weak var soySwitch: UISwitch!
    
    var delegate: UpdateListDelegate?
    var expiredDate: Date?
    
    var product = Product()
    
    var editCell: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DoneButton()
        
        expiredLabel.isHidden = true
        
        // ---- Fill Text Fields with Info-----
        itemNameTextField.text = product.productName
        brandTextField.text = product.brandName
        quantityTextField.text = String(product.quantity)
        priceTextField.text = String(product.price)
        
        if product.containsPalm == true{
            palmSwitch.isOn = true
        }else{
            palmSwitch.isOn = false
        }
        
        if product.containsDairy == true{
            dairySwitch.isOn = true
        }else{
            dairySwitch.isOn = false
        }
        
        if product.containsNuts == true{
            nutSwitch.isOn = true
        }else{
            nutSwitch.isOn = false
        }
        
        if product.containsWheat == true{
            wheatSwitch.isOn = true
        }else{
            wheatSwitch.isOn = false
        }
        
        if product.containsSoy == true{
            soySwitch.isOn = true
        }else{
            soySwitch.isOn = false
        }
        
        //----DATE PICKER-----
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
        
        //Autofill date if date was already entered previously
        guard let expiry = product.expDate else{
            print("No Date")
            return
        }
        expDateTextField.text =  Product.date(input: expiry)
        
        expiredDate = expiry
        
        product.calculateExpiry(date: expiry)
        
        if product.isExpired == true{
            expiredLabel.isHidden = false
        }else{
            expiredLabel.isHidden = true
        }
    }

    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        
        let formatter = DateFormatter()
        
        //show only date, not time
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        
        //show chosen date in text field
        expiredDate = sender.date
        expDateTextField.text = formatter.string(from: sender.date)
        
        // Calculate Expiration
        guard let expiry = expiredDate else{
            print("No Date")
            return
        }
        
        product.calculateExpiry(date: expiry)
        
        if product.isExpired == true{
            expiredLabel.isHidden = false
        }else{
            expiredLabel.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // Used for Saving Items
    func DoneButton(){
        // Create new list button using AddNewList as a selector
        let addDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(Done(sender:)))
        self.navigationItem.rightBarButtonItem = addDoneButton
    }
    
    @IBAction func RevertTextColor(_ sender: Any) {
        itemNameTextField.textColor = .black
    }
    
    @IBAction func revertQuantitColor(_ sender: Any) {
        quantityTextField.textColor = .black
    }
    @objc func Done(sender: UIBarButtonItem){
        // Save Info from Text Fields
        product.expDate = expiredDate
        
        if (itemNameTextField.text != "" && itemNameTextField.text != "Enter Product Name" && quantityTextField.text != "0")
        {
            product.productName = itemNameTextField.text ?? "No Product Name"
            product.brandName = brandTextField.text ?? "No Product Name"
            product.quantity = Int(quantityTextField.text ?? "1") ?? 1
            //product.price = Double(priceTextField.text ?? "0.00") ?? 0.00
            product.price = priceTextField.text ?? "No Price"
            
            //save Palm
            if palmSwitch.isOn {
                product.containsPalm = true
            } else {
                product.containsPalm = false
            }
            
            //saveDairy
            if dairySwitch.isOn {
                product.containsDairy = true
            } else {
                product.containsDairy = false
            }
            
            //saveNut
            if nutSwitch.isOn {
                product.containsNuts = true
            } else {
                product.containsNuts = false
            }
            
            //saveWheat
            if wheatSwitch.isOn {
                product.containsWheat = true
            } else {
                product.containsWheat = false
            }
            
            //saveSoy
            if soySwitch.isOn {
                product.containsSoy = true
            } else {
                product.containsSoy = false
            }
            
            self.delegate?.ListUpdate(finishedProduct: product, isEditing: editCell)
            
            // If the IndividualListViewController is on the stack, pop to it
            // Otherwise, pop to root
            if let viewControllers = self.navigationController?.viewControllers{
                for controllers in viewControllers{
                    if controllers.isKind(of: IndividualListViewController.self){
                        // Pop to IndividualListViewController
                        self.navigationController?.popToViewController(controllers, animated: true)
                        return
                    }
                }
            }
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }else if (itemNameTextField.text == "" || itemNameTextField.text == "Enter Product Name"){
            itemNameTextField.resignFirstResponder()
            itemNameTextField.textColor = .red
            itemNameTextField.text = "Enter Product Name"
        }else if (quantityTextField.text == "0"){
            quantityTextField.resignFirstResponder()
            quantityTextField.textColor = .red
            quantityTextField.text = "Invalid Quantity"
        }
        
    }
    
}
