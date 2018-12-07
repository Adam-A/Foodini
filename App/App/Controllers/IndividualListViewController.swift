//
//  IndividualListViewController.swift
//  App
//
//  Created by William Chilcote on 11/16/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

protocol UpdateShoppingListDelegate{
    func UpdateTableContents()
}

class IndividualListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UpdateListDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    @IBOutlet weak var table: UITableView!
    var list = List()
    var delegate: UpdateShoppingListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Generate the "Add" button in the top right
        let newItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(NewItem(sender:)))
        self.navigationItem.rightBarButtonItem = newItem
        
        table.dataSource = self
        table.delegate = self
        
        //DZNEmptyDataSet
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
        table.tableFooterView = UIView()
        table.reloadData()
    }
    
    @objc func NewItem(sender: UIBarButtonItem){
        
        let alert = UIAlertController(title: "New item", message: "Add an item", preferredStyle: .alert)
        
        // Generate a text field
        alert.addTextField { (textField) in textField.text = "" }
        
        // Add "Quick Add" button to alert
        alert.addAction(UIAlertAction(title: "Quick Add", style: .default, handler: { (action) in
            if let text = alert.textFields?[0].text{
                
                if text == "" {
                    alert.actions[0].isEnabled = false
                } else {
                    // Create new list
                    alert.actions[0].isEnabled = true
                    let product = Product.init(productName: text)
                    self.ListUpdate(finishedProduct: product, isEditing: false)
                }
            } else {
                // Error occured
                print("An error has occurred when trying to add a new item")
            }
            
        }))
        
        // Add "Item Details" button to alert
        alert.addAction(UIAlertAction(title: "Item Details", style: .default, handler: { (action) in
            if let text = alert.textFields?[0].text{
                
                // Init product using text field as name
                let product = Product.init(productName: text)
                
                self.table.reloadData()
                
                // Create and push EditItemViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "editItemViewController") as! EditItemViewController
                
                // Set EditItemViewController vars
                viewController.delegate = self
                viewController.product.productName = text
                viewController.product = product
                viewController.editCell = false
                
                self.navigationController?.pushViewController(viewController, animated: true)
                
            } else {
                // Error occured
                print("An error has occurred when trying to add a new item")
            }
            
        }))
        
        // Add "Barcode" button to alert
        alert.addAction(UIAlertAction(title: "Barcode", style: .default, handler: { (action) in
            
            // Init product
            let product = Product.init(productName: "")
            self.table.reloadData()
            
            // Create and push BarcodeViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "barcodeViewController") as! BarcodeViewController
            
            // Set BarcodeViewController vars
            viewController.product = product
            viewController.delegate = self
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func ListUpdate(finishedProduct: Product, isEditing: Bool) {
        if isEditing == false{
            self.list.products.append(finishedProduct)
        }
        self.delegate?.UpdateTableContents()
        // Serialize data
        //SerializeData()
        self.table.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of cells to generate
        return list.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Generate cells with list contents
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") ?? UITableViewCell(style: .default, reuseIdentifier: "itemCell")
        // Set text to item name
        cell.textLabel?.text = list.products[indexPath.row].productName
        cell.detailTextLabel?.text = "\(list.products[indexPath.row].quantity)";
        if list.products[indexPath.row].wasPurchased == true {
            //cell.backgroundColor = UIColor.lightGray
            cell.accessoryType = .checkmark
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // Delete the cell at the given index
            list.products.remove(at: indexPath.row)
            tableView.reloadData()
            // Update ShoppingListViewController when removing an object
            self.delegate?.UpdateTableContents()
        }
    }
    
    // If a user selects a cell open the list view for that cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
        if self.list.products[indexPath.row].wasPurchased != true{
            //INSERT CODE TO VIEW ITEM DETAILS VIEW CONTROLLER
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "editItemViewController") as! EditItemViewController
            
            //Push current VC onto backstack
            viewController.delegate = self
            viewController.product = self.list.products[indexPath.row]
            viewController.editCell = true
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if self.list.products[indexPath.row].wasPurchased == true{
            return UISwipeActionsConfiguration(actions: [])
        }
        
        let addItem = UIContextualAction(style: .normal, title:  "To Pantry", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            //self.table.cellForRow(at: indexPath)?.backgroundColor = UIColor.lightGray
            self.table.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.list.products[indexPath.row].wasPurchased = true
            self.ListUpdate(finishedProduct: self.list.products[indexPath.row], isEditing: true)
            //self.SerializeData(listToSave: self.list)
    
            // Each time you check an item off the shopping list, load the pantry and append to the list
            // Then save the pantry list list
            let loadedList = self.LoadData()
            if let loadedList = loadedList{
                loadedList.products.append(self.list.products[indexPath.row])
                self.SerializeData(listToSave: loadedList)
            }
            
            success(true)
        })
        addItem.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [addItem])
    }
    
    func LoadData() -> List?{
        // Put on a background thread
        if let listData = UserDefaults.standard.value(forKey: "PantryList") as? Data{
            do {
                let loadedList = try PropertyListDecoder().decode(List.self, from: listData)
                return loadedList
            } catch {
                // If the pantry list couldn't be loaded, return nil
                print("Couldn't retrieve data for individual list")
                return nil
            }
        }
        // If no pantry list exists, return an initializer
        return List()
    }
    
    func SerializeData(listToSave: List){
        // Put on a background thread
        do {
            let serializedList = try PropertyListEncoder().encode(listToSave)
            UserDefaults.standard.set(serializedList, forKey: "PantryList")
        } catch {
            return
        }
    }

    
    //-----DZNEmptyDataSet cocoapod use -----
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let title = "Let's Get Started"
        let Attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: title, attributes: Attributes)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "IndListEmptyState")
    }
}
