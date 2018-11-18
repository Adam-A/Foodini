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

class PantryViewController: UIViewController, UITableViewDataSource {
    
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PantryTableView.deselectRow(at: indexPath, animated: true)
        
        //INSERT CODE TO VIEW ITEM DETAILS VIEW CONTROLLER
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

        PantryTableView.dataSource = self
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
    


}
