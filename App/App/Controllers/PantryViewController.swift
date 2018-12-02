//
//  PantryViewController.swift
//  App
//
//  Created by Sydney Schiller on 11/17/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import UIKit

class PantryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UpdateListDelegate {
    
    var product = Product()
    var list = List()
    
    //Shows the Appropriate amount of Cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemCount
    }
    
    //Display Table Contents
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Populate cells as list cells
        let cell = PantryTableView.dequeueReusableCell(withIdentifier: "listCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "listCell")
        // Set text label to list name
        cell.textLabel?.text = "\(list.products[indexPath.row].productName)"
        // Set detail label to the items in the list
        cell.detailTextLabel?.text = "\(list.products[indexPath.row].quantity)"
        
//        let cells = PantryTableView.visibleCells(in: 1)
//        UIView.animate(views: cells, animations: [rotateAnimation, fadeAnimation])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PantryTableView.deselectRow(at: indexPath, animated: true)
        
        //INSERT CODE TO VIEW ITEM DETAILS VIEW CONTROLLER
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "editItemViewController") as! EditItemViewController
        viewController.delegate = self
        //Push current VC onto backstack
        viewController.product = self.list.products[indexPath.row]
        viewController.isEditing = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            // Delete cell at position
            list.products.remove(at: indexPath.row)
            itemCount = list.products.count
            PantryTableView.reloadData()
        }
    }
    

    @IBOutlet weak var PantryTableView: UITableView!
    
    var itemCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        PantryTableView.dataSource = self
        PantryTableView.delegate = self
        itemCount = list.products.count
        CreateNewItemButton()
        LoadData()
    }
    
    func LoadData(){
        // Put on a background thread
        if let listData = UserDefaults.standard.value(forKey: "PantryList") as? Data{
            print("List Data exists")
            do {
                print("==============LOADING============")
                list = try PropertyListDecoder().decode(List.self, from: listData)
                itemCount = list.products.count
                PantryTableView.reloadData()
            } catch {
                print("Couldn't retrieve data")
                return
            }
        }
    }
    
    func SerializeData(){
        // Put on a background thread
        do {
            print("==============SAVING============")
            let serializedList = try PropertyListEncoder().encode(self.list)
            UserDefaults.standard.set(serializedList, forKey: "PantryList")
        } catch {
            print("++++++++Couldn't++++++++")
            return
        }
    }
    
    // Save Items from EditItemViewController
    func ListUpdate(finishedProduct: Product, isEditing: Bool) {
        if isEditing == false{
            self.list.products.append(finishedProduct)
        }
        self.itemCount = self.list.products.count
        // Serialize data
        SerializeData()
        self.PantryTableView.reloadData()
    }
    
    // Used for adding additional items to Pantry
    func CreateNewItemButton(){
        // Create new list button using AddNewList as a selector
        let addNewItemButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddNewItem(sender:)))
        self.navigationItem.rightBarButtonItem = addNewItemButton
    }
    
    @objc func AddNewItem(sender: UIBarButtonItem){
        // Uses alert with text field to create a named list
        let popup = UIAlertController(title: "New Item", message: "Add an item", preferredStyle: .alert)
        
        // Add text field to alert and autofill with "List"
        popup.addTextField { (textField) in
            textField.text = "List"
        }
        // Add "Quick Add" button to alert
        popup.addAction(UIAlertAction(title: "Quick Add", style: .default, handler: { (action) in
            if let text = popup.textFields?[0].text{
                // Create new list
                self.product = Product.init(productName: text)
                self.list.products.append(self.product)
                self.itemCount = self.list.products.count
                //self.pantryItems.append(self.product)
                //self.itemCount = self.pantryItems.count
                self.SerializeData()
                self.PantryTableView.reloadData()
            } else {
                // Error occured
                print("An error has occurred when trying to add a new item")
            }
            
        }))
        
        // Add "Item Details" button to alert
        popup.addAction(UIAlertAction(title: "Item Details", style: .default, handler: { (action) in
            if let text = popup.textFields?[0].text{
                
                // Init product using text field as name
                self.product = Product.init(productName: text)
                // Add product to table view
                //self.list.products.append(self.product)
                
                // Create and push EditItemViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "editItemViewController") as! EditItemViewController
                
                // Set EditItemViewController vars
                viewController.delegate = self
                viewController.product.productName = text
                viewController.product = self.product
                viewController.isEditing = false
                
                self.navigationController?.pushViewController(viewController, animated: true)
                
            } else {
                // Error occured
                print("An error has occurred when trying to add a new item")
            }
            
        }))
        
        // Add "Barcode" button to alert
        popup.addAction(UIAlertAction(title: "Barcode", style: .default, handler: { (action) in
            
            // Init product
            self.product = Product.init(productName: "")
            // Add product to table view
            //self.list.products.append(self.product)
            
            // Create and push BarcodeViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "barcodeViewController") as! BarcodeViewController
            
            // Set BarcodeViewController vars
            viewController.product = self.product
            viewController.delegate = self
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }))
        
        popup.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in }))
        
        self.present(popup, animated: true, completion: nil)

    }
    
    
    @IBAction func onListsPress(_ sender: Any) {
        // Save data before transferring
        
         // Create the pantry VC
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: "shoppingListViewController") as! ShoppingListViewController
         //viewController.delegate = self
          //Push current VC onto backstack
         self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    
    @IBAction func onRecipePress(_ sender: Any) {
        // Save data before transferring
        
         // Create the pantry VC
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: "RecipesViewController") as! RecipesViewController
         //viewController.delegate = self
         // Push current VC onto backstack
         self.navigationController?.pushViewController(viewController, animated: false)
        
    }
    

    @IBAction func onSettingsPress(_ sender: Any) {
        // Save data before transferring
        
         // Create the pantry VC
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
         //viewController.delegate = self
         // Push current VC onto backstack
         self.navigationController?.pushViewController(viewController, animated: false)
        
    }
}
