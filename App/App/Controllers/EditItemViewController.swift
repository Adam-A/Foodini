//
//  EditItemViewController.swift
//  App
//
//  Created by Sydney Schiller on 11/26/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import UIKit

protocol UpdateListDelegate{
    func ListUpdate(finishedProduct: Product, isEditing: Bool)
}


class EditItemViewController: UIViewController {
    
    @IBOutlet weak var expDateTextField: UITextField!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    var delegate: UpdateListDelegate?
    
    var product = Product()
    
    var editCell: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DoneButton()
        
        // Fill Text Fields with Info
        itemNameTextField.text = product.productName
        quantityTextField.text = String(product.quantity)
        priceTextField.text = String(product.price)
        //expDateTextField.text = FillDate(product.expDate)
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
    
//    @objc func FillDate(sender: product.expDate){
//
//        let formatter = DateFormatter()
//
//        //show only date, not time
//        formatter.dateStyle = DateFormatter.Style.medium
//        formatter.timeStyle = DateFormatter.Style.none
//
//        //show chosen date in text field
//        product.expDate = sender.date
//        expDateTextField.text = formatter.string(from: sender.date)
//    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        
        let formatter = DateFormatter()
        
        //show only date, not time
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        
        //show chosen date in text field
        product.expDate = sender.date
        expDateTextField.text = formatter.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //Save Items when done
    
    // Used for Saving Items
    func DoneButton(){
        // Create new list button using AddNewList as a selector
        let addDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(Done(sender:)))
        self.navigationItem.rightBarButtonItem = addDoneButton
    }
    
    @objc func Done(sender: UIBarButtonItem){
        // Save Info from Text Fields
        product.productName = itemNameTextField.text ?? "No Product Name"
        product.quantity = Int(quantityTextField.text ?? "1") ?? 1
        product.price = Double(priceTextField.text ?? "0.00") ?? 0.00
        
        // Switch to Previous View Controller
        self.delegate?.ListUpdate(finishedProduct: product, isEditing: editCell)
        self.navigationController?.popToRootViewController(animated: true)

//        if let listOfViewControllers = self.navigationController?.viewControllers{
//            for viewController in listOfViewControllers {
//                print(viewController)
//                // This doesn't work...
//                if viewController.isKind(of: PantryViewController.self){
//                    self.navigationController?.popToViewController(viewController, animated: true)
//                } else {
//                    print("Unable to get Pantry View Controller")
//                    self.navigationController?.popViewController(animated: true)
//                }
//            }
//        } else {
//            print("Unable to get list of view controllers")
//            self.navigationController?.popViewController(animated: true)
//        }
    }
    
}
