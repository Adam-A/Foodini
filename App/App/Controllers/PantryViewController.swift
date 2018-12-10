//
//  PantryViewController.swift
//  App
//
//  Created by Sydney Schiller on 11/17/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//
// Followed tutorial at https://www.hackingwithswift.com/example-code/libraries/how-to-make-empty-uitableviews-look-more-attractive-using-dznemptydataset
// for help using DZNEmptyDataSet cocoapod

import UIKit
import DZNEmptyDataSet

class PantryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UpdateListDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var list = List()
    
    //Shows the Appropriate amount of Cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.products.count
    }
    
    //Display Table Contents
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Populate cells as list cells
        let cell = PantryTableView.dequeueReusableCell(withIdentifier: "listCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "listCell")
        // Set text label to list name
        cell.textLabel?.text = "\(list.products[indexPath.row].productName)"
        // Set detail label to the items in the list
        cell.detailTextLabel?.text = "\(list.products[indexPath.row].quantity)"
        
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
        viewController.editCell = true

        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            // Delete cell at position
            list.products.remove(at: indexPath.row)
            PantryTableView.reloadData()
            SerializeData()
        }
    }
    

    @IBOutlet weak var PantryTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        PantryTableView.dataSource = self
        PantryTableView.delegate = self
        
        PantryTableView.emptyDataSetSource = self
        PantryTableView.emptyDataSetDelegate = self
        PantryTableView.tableFooterView = UIView()
        
        CreateNewItemButton()
        LoadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Load pantry list when view appears
        LoadData()
    }
    
    func LoadData(){
        // Put on a background thread
        if let listData = UserDefaults.standard.value(forKey: "PantryList") as? Data{
            do {
                list = try PropertyListDecoder().decode(List.self, from: listData)
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
            let serializedList = try PropertyListEncoder().encode(self.list)
            UserDefaults.standard.set(serializedList, forKey: "PantryList")
        } catch {
            return
        }
    }
    
    // Save Items from EditItemViewController
    func PantryListUpdate(finishedProduct: Product, isEditing: Bool) {
        if isEditing == false{
            self.list.products.append(finishedProduct)
        }
        // Serialize data
        SerializeData()
    }
    
    func ListUpdate(finishedProduct: Product, isEditing: Bool) {
        if isEditing == false{
            self.list.products.append(finishedProduct)
        }
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
            textField.text = ""
        }
        // Add "Quick Add" button to alert
        popup.addAction(UIAlertAction(title: "Quick Add", style: .default, handler: { (action) in
            if let text = popup.textFields?[0].text{
                
                if text == "" {
                    popup.actions[0].isEnabled = false
                } else {
                    // Create new list
                    popup.actions[0].isEnabled = true
                    let product = Product.init(productName: text)
                    self.list.products.append(product)

                    self.SerializeData()
                    self.PantryTableView.reloadData()
                }
            } else {
                // Error occured
                print("An error has occurred when trying to add a new item")
            }
            
        }))
        
        // Add "Item Details" button to alert
        popup.addAction(UIAlertAction(title: "Item Details", style: .default, handler: { (action) in
            if let text = popup.textFields?[0].text{
                
                // Init product using text field as name
                let product = Product.init(productName: text)
                
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
        popup.addAction(UIAlertAction(title: "Barcode", style: .default, handler: { (action) in
            
            // Init product
            let product = Product.init(productName: "")
            
            // Create and push BarcodeViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "barcodeViewController") as! BarcodeViewController
            
            // Set BarcodeViewController vars
            viewController.product = product
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

          //Push current VC onto backstack
         self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    
    @IBAction func onRecipePress(_ sender: Any) {
        // Save data before transferring
        
         // Create the pantry VC
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: "RecipesViewController") as! RecipesViewController

         // Push current VC onto backstack
         self.navigationController?.pushViewController(viewController, animated: false)
        
    }
    

    @IBAction func onSettingsPress(_ sender: Any) {
        // Save data before transferring
        
         // Create the pantry VC
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController

         // Push current VC onto backstack
         self.navigationController?.pushViewController(viewController, animated: false)
        
    }
    
    //-----DZNEmptyDataSet cocoapod use -----
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let title = "Welcome To Your Pantry"
        let Attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: title, attributes: Attributes)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "PantryEmptyState")
    }
}
