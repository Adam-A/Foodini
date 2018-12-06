//
//  ShoppingListViewController.swift
//  App
//
//  Created by Mark Nickerson on 11/17/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//
// TODO:
// [] Serilization

import UIKit
import DZNEmptyDataSet

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UpdateShoppingListDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    // Begin outlet definitions
    @IBOutlet weak var tableView: UITableView!
    
    // reference to ProductModel
    var masterList = ListStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        CreateNewListButton()
        
        LoadData()
        
        //DZNEmptyDataSet
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LoadData()
    }
    
    func CreateNewListButton(){
        // Create new list button using AddNewList as a selector
        let addNewListButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddNewList(sender:)))
        self.navigationItem.rightBarButtonItem = addNewListButton
    }
    
    func LoadData(){
        // Put on a background thread
        if let listData = UserDefaults.standard.value(forKey: "MasterShoppingList") as? Data{
            do {
                masterList = try PropertyListDecoder().decode(ListStorage.self, from: listData)
                tableView.reloadData()
            } catch {
                print("Couldn't retrieve data")
                return
            }
        }
    }
    
    func SerializeData(){
        // Put on a background thread
        do {
            let serializedList = try PropertyListEncoder().encode(self.masterList)
            UserDefaults.standard.set(serializedList, forKey: "MasterShoppingList")
        } catch {
            return
        }
    }
    
    @objc func AddNewList(sender: UIBarButtonItem){
        // Uses alert with text field to create a named list
        let popup = UIAlertController(title: "New list", message: "Add a name", preferredStyle: .alert)
        
        // Add text field to alert and autofill with "List"
        popup.addTextField { (textField) in
            textField.text = ""
        }
        // Add "create" button to alert
        popup.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action) in
            if var text = popup.textFields?[0].text{
                if text == "" {
                    text = "List"
                }
                // Create new list
                let newShoppingList = List.init(name: text)
                self.masterList.addToLists(list: newShoppingList)
                
                // Instantiate instance of IndividualListViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "individualListViewController") as! IndividualListViewController
                // Assign the relevent ShoppingList to the next VC
                viewController.list = newShoppingList
                viewController.title = newShoppingList.name
                viewController.delegate = self
                // Push current VC onto backstack
                self.navigationController?.pushViewController(viewController, animated: true)

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
        SerializeData()
        // Create the pantry VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PantryViewController") as! PantryViewController
        //viewController.delegate = self
        // Push current VC onto backstack
        self.navigationController?.pushViewController(viewController, animated: false)
 
    }
    
    @IBAction func onRecipePress(_ sender: Any) {
        // Save data before transferring
        SerializeData()
         // Create the pantry VC
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: "RecipesViewController") as! RecipesViewController
         //viewController.delegate = self
         // Push current VC onto backstack
         self.navigationController?.pushViewController(viewController, animated: false)
        
    }
    
    @IBAction func onSettingsPress(_ sender: Any) {
        // Save data before transferring
        SerializeData()
         // Create the pantry VC
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
         //viewController.delegate = self
         // Push current VC onto backstack
         self.navigationController?.pushViewController(viewController, animated: false)
         
    }
    
    func UpdateTableContents() {
        // Save data
        SerializeData()
        tableView.reloadData()
    }
    
    //-----DZNEmptyDataSet cocoapod use-----
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let title = "Make Your Lists Here"
        let Attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: title, attributes: Attributes)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "MasterListEmptyState")
    }
    
    
    //-----Table View-----
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // How many cells to create
        return masterList.Lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Populate cells as list cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "listCell")
        // Set text label to list name
        
        cell.textLabel?.text = "\(masterList.Lists[indexPath.row].name)"
        // Set detail label to the items in the list
        
        cell.detailTextLabel?.text = "\(masterList.Lists[indexPath.row].returnProducts())"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            // Delete cell at position
            masterList.removeList(index: indexPath.row)
            SerializeData()
            tableView.reloadData()
        }
    }
    
    // If a user selects a cell open the list view for that cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect row
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Instantiate instance of IndividualListViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "individualListViewController") as! IndividualListViewController
        // Assign the relevent ShoppingList to the next VC
        viewController.list = masterList.Lists[indexPath.item]
        viewController.title = masterList.Lists[indexPath.item].name
        viewController.delegate = self
        // Push current VC onto backstack
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}
