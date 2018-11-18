//
//  PantryViewController.swift
//  App
//
//  Created by Sydney Schiller on 11/17/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import UIKit

// REPLACE WITH MODEL
struct GroceryItem{
    var item: String = ""
    var quantity: Int = 0
    //var expDate: String = ""
}

class PantryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Shows the Appropriate amound of Cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemCount
    }
    
    //Display Table Contents
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Populate cells as list cells
        let cell = PantryTableView.dequeueReusableCell(withIdentifier: "listCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "listCell")
        // Set text label to list name
        cell.textLabel?.text = "\(pantryItems[indexPath.row].item)"
        // Set detail label to the items in the list
        cell.detailTextLabel?.text = "\(pantryItems[indexPath.row].quantity)"
        
//        let cells = PantryTableView.visibleCells(in: 1)
//        UIView.animate(views: cells, animations: [rotateAnimation, fadeAnimation])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PantryTableView.deselectRow(at: indexPath, animated: true)
        
        //INSERT CODE TO VIEW ITEM DETAILS VIEW CONTROLLER
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            // Delete cell at position
            pantryItems.remove(at: indexPath.row)
            itemCount = pantryItems.count
            PantryTableView.reloadData()
        }
    }
    

    @IBOutlet weak var PantryTableView: UITableView!
    
    var itemCount: Int = 0
    
    // ------- REMOVE LATER --------------
    var pantryItems: [GroceryItem] =
        [GroceryItem.init(item: "Apple", quantity: 5),
         GroceryItem.init(item: "Oranges", quantity: 4),
         GroceryItem.init(item: "Milk", quantity: 1),
         GroceryItem.init(item: "Tuna", quantity: 1),
         GroceryItem.init(item: "Sugar", quantity: 2)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        PantryTableView.dataSource = self
        PantryTableView.delegate = self
        itemCount = pantryItems.count
        CreateNewItemButton()
    }
    
    // Used for adding additional items to Pantry
    func CreateNewItemButton(){
        // Create new list button using AddNewList as a selector
        let addNewItemButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddNewItem(sender:)))
        self.navigationItem.rightBarButtonItem = addNewItemButton
    }
    
    @objc func AddNewItem(sender: UIBarButtonItem){
        // INSERT CODE TO SWITCH TO ADD ITEM VIEW CONTROLLER
    }
    
    // Need to override setEditing in order to actually edit cells in tableView
    override func setEditing(_ editing: Bool, animated: Bool) {
        // If the edit button title is "Done"
        if navigationItem.leftBarButtonItem?.title == "Done"{
            // tableView is not being edited
            PantryTableView.isEditing = false
            // Switch done button to "Edit"
            navigationItem.leftBarButtonItem?.title = "Edit"
        } else { // If the edit button title is "Edit"
            // tableView is being edited
            PantryTableView.isEditing = true
            // Switch edit button to "Done"
            navigationItem.leftBarButtonItem?.title = "Done"
        }
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
        /*
         // Create the pantry VC
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: "recipeViewController") as! RecipeViewController
         //viewController.delegate = self
         // Push current VC onto backstack
         self.navigationController?.pushViewController(viewController, animated: true)
         */
    }
    

    @IBAction func onSettingsPress(_ sender: Any) {
        // Save data before transferring
        /*
         // Create the pantry VC
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: "settingsViewController") as! SettingsViewController
         //viewController.delegate = self
         // Push current VC onto backstack
         self.navigationController?.pushViewController(viewController, animated: true)
         */
    }
}
