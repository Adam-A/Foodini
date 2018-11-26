//
//  RecipesViewController.swift
//  App
//
//  Created by Adam Ali on 11/18/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
    
}

class RecipesViewController: UITableViewController {

    var tableViewData = [cellData]()
    override func viewDidLoad() {
    super.viewDidLoad()
        
        /* TEST DATA */
        tableViewData = [cellData(opened: false, title: "Rice and Beans", sectionData: ["Rice", "Beans", "Salt"]),cellData(opened: false, title: "Curry Chicken", sectionData: ["Curry", "Chicken"]),cellData(opened: false, title: "Mac n Cheese", sectionData: ["Mac", "Cheese"])]
}
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
            
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex]
           return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        if tableViewData[indexPath.section].opened == true {
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
        } else {
            //dont close cells
        }
    }
    
    
    /*
    @IBAction func onPantryPress(_ sender: Any) {
        // Save data before transferring
        self.navigationItem.hidesBackButton = false;
        recipesViewButton.isEnabled = true
        // Create the pantry VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PantryViewController") as! PantryViewController
        //viewController.delegate = self
        // Push current VC onto backstack
        self.navigationController?.pushViewController(viewController, animated: false)
        
    }
    
    @IBAction func onSettingsPress(_ sender: Any) {
        // Save data before transferring
        
        // Create the pantry VC
        self.navigationItem.hidesBackButton = false;
        recipesViewButton.isEnabled = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        //viewController.delegate = self
        // Push current VC onto backstack
        self.navigationController?.pushViewController(viewController, animated: false)
        
    }
    
    @IBAction func onListsPress(_ sender: Any) {
        // Save data before transferring
        self.navigationItem.hidesBackButton = false;
        recipesViewButton.isEnabled = true
        // Create the pantry VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "shoppingListViewController") as! ShoppingListViewController
        //viewController.delegate = self
        //Push current VC onto backstack
        self.navigationController?.pushViewController(viewController, animated: false)
        
    }
 */
}
