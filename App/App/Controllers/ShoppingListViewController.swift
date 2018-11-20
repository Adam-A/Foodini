//
//  ShoppingListViewController.swift
//  App
//
//  Created by Mark Nickerson on 11/17/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//
// TODO:
// [] Serilization
// [] Update to use model
// [] Clean up temp struct stuff

import UIKit

// REMOVE: replace with model
struct ShoppingList{
    var name: String = ""
    var listItems: [String] = []
}

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // How many cells to create
        // return number of lists user has
        // REMOVE
        return listCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Populate cells as list cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "listCell")
        // Set text label to list name
        cell.textLabel?.text = "\(shoppingLists[indexPath.row].name)"
        // Set detail label to the items in the list
        cell.detailTextLabel?.text = "\(shoppingLists[indexPath.row].listItems)"
        return cell

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            // Delete cell at position
            shoppingLists.remove(at: indexPath.row)
            listCount = shoppingLists.count
            tableView.reloadData()
        }
    }
    
    // If a user selects a cell open the list view for that cell
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect row
        tableView.deselectRow(at: indexPath, animated: true)
        /*
        // Create the wallet VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "individualListViewController") as! IndividualListViewController
        //viewController.delegate = self
        // Push current VC onto backstack
        self.navigationController?.pushViewController(viewController, animated: true)
        */
        
    }
    
    // Begin outlet definitions
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listButton: UIButton!
    
    // REMOVE
    var listCount: Int = 0
    var shoppingLists: [ShoppingList] =
        [ShoppingList.init(name: "Safeway", listItems: ["Peas", "Carrots"]),
         ShoppingList.init(name: "Sprouts", listItems: ["Apples", "Oranges", "Eggs"]),
         ShoppingList.init(name: "Trader Joe's", listItems: ["Leeks"]),
         ShoppingList.init(name: "Farmer's Market", listItems: ["Lettuce", "Tomatoes", "Potatoes", "Cabbage"]),
         ShoppingList.init(name: "Nugget", listItems: ["Flour", "Butter"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        // Disable button for current view
        listButton.isEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        CreateNewListButton()
        
        //REMOVE
        listCount = shoppingLists.count
    }
    
    func CreateNewListButton(){
        // Create new list button using AddNewList as a selector
        let addNewListButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddNewList(sender:)))
        self.navigationItem.rightBarButtonItem = addNewListButton
    }
    
    @objc func AddNewList(sender: UIBarButtonItem){
        // Uses alert with text field to create a named list
        let popup = UIAlertController(title: "New list", message: "Add a name", preferredStyle: .alert)
        
        // Add text field to alert and autofill with "List"
        popup.addTextField { (textField) in
            textField.text = "List"
        }
        // Add "create" button to alert
        popup.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action) in
            if let text = popup.textFields?[0].text{
                // Create new list
                let newShoppingList = ShoppingList.init(name: text, listItems: [])
                self.shoppingLists.append(newShoppingList)
                self.listCount = self.shoppingLists.count
                self.tableView.reloadData()
            } else {
                // Error occured
                print("An error has occurred when trying to add a new list")
            }
            
        }))
        
        popup.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in }))
        
        self.present(popup, animated: true, completion: nil)
    }
    
    // Need to override setEditing in order to actually edit cells in tableView
    override func setEditing(_ editing: Bool, animated: Bool) {
        // If the edit button title is "Done"
        if navigationItem.leftBarButtonItem?.title == "Done"{
            // tableView is not being edited
            tableView.isEditing = false
            // Switch done button to "Edit"
            navigationItem.leftBarButtonItem?.title = "Edit"
        } else { // If the edit button title is "Edit"
            // tableView is being edited
            tableView.isEditing = true
            // Switch edit button to "Done"
            navigationItem.leftBarButtonItem?.title = "Done"
        }
    }

    @IBAction func onPantryPress(_ sender: Any) {
        // Save data before transferring
        
        // Create the pantry VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PantryViewController") as! PantryViewController
        //viewController.delegate = self
        // Push current VC onto backstack
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
        
         // Create the pantry VC
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
         //viewController.delegate = self
         // Push current VC onto backstack
         self.navigationController?.pushViewController(viewController, animated: true)
         
    }
    
}
