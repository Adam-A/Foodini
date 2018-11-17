//
//  ShoppingListViewController.swift
//  App
//
//  Created by Mark Nickerson on 11/17/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//
// TODO:
// [] Serilization
// [x] Add list button:
//      [x] Name prompt
//      [x] Add to list, update table view
// [] Edit lists:
//      [] delete
// [] Navigation buttons to other views
// [] Update to use model
// [] Click on list opens new view
// [] Add error checking

import UIKit

// REMOVE: replace with model
struct ShoppingList{
    var name: String = ""
    var listItems: [String] = []
}

class ShoppingListViewController: UIViewController, UITableViewDataSource {
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
    
    // If a user selects a cell open the list view for that cell
    /* func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect row
        tableView.deselectRow(at: indexPath, animated: true)
        // Create the wallet VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "accountViewController") as! AccountViewController
        viewController.accountName = "\(myWallet.accounts[indexPath.row].name)"
        viewController.rowIndex = indexPath.row
        viewController.delegate = self
        // Push current VC onto backstack
        self.navigationController?.pushViewController(viewController, animated: true)
    } */
    
    // Begin outlet definitions
    @IBOutlet weak var tableView: UITableView!
    
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
        tableView.dataSource = self
        CreateEditButton()
        CreateNewListButton()
        
        //REMOVE
        listCount = shoppingLists.count
    }
    
    func CreateEditButton(){
        // Hide back button
        self.navigationItem.hidesBackButton = true;
        // Create edit button using EditLists as a selector
        let editButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(EditLists(sender:)))
        
        self.navigationItem.leftBarButtonItem = editButton
    }
    
    func CreateNewListButton(){
        // Create new list button using AddNewList as a selector
        let addNewListButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddNewList(sender:)))
        self.navigationItem.rightBarButtonItem = addNewListButton
    }
    
    @objc func EditLists(sender: UIBarButtonItem){
        
    }
    
    @objc func AddNewList(sender: UIBarButtonItem){
        // Uses alert with text field to create a named list
        // Start alert
        let popup = UIAlertController(title: "New list", message: "Add a name", preferredStyle: .alert)
        popup.addTextField { (textField) in
            textField.text = "List"
        }
        popup.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action) in
            if let text = popup.textFields?[0].text{
                // Create new list
                let newShoppingList = ShoppingList.init(name: text, listItems: [])
                self.shoppingLists.append(newShoppingList)
                self.listCount = self.shoppingLists.count
                self.tableView.reloadData()
            } else {
                // Error occured
                print("==============ERROR==============")
            }
            
        }))
        
        self.present(popup, animated: true, completion: nil)
    }

}
