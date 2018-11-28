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

    @IBOutlet weak var rouletteButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    var tableViewData = [cellData]()
    override func viewDidLoad() {
    super.viewDidLoad()
        
        /* TEST DATA */
        tableViewData = [cellData(opened: false, title: "Rice and Beans", sectionData: ["Rice", "Beans", "Salt"]),cellData(opened: false, title: "Curry Chicken", sectionData: ["Curry", "Chicken"]),cellData(opened: false, title: "Mac n Cheese", sectionData: ["Mac", "Cheese"])]
        
        
}
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count    }
    
    
    //if user has a cell opened and they hit edit, it retracts the cells -- I just like the way it looks
    func retractCellsIfExtended() {
        for (index, _) in tableViewData.enumerated(){
            if (tableViewData[index].opened) { tableViewData[index].opened = false }
        }
        tableView.reloadData()
    }
    
    @IBAction func recipeRoulette(){
        let edamamEndpoint: String = "https://api.edamam.com/search?q=chicken&app_id=$57137e17&app_key=$630a79c36b59b59acca9fa0461eb2329&from=0&to=3&calories=591-722&health=alcohol-free"
        
        //https://api.edamam.com/search?q=chicken&app_id=${YOUR_APP_ID}&app_key=${YOUR_APP_KEY}&from=0&to=3&calories=591-722&health=alcohol-free
        
        //"https://api.edamam.com/search?app_id=${57137e17}&app_key=${4a3e0bd717007d50a87e60f20e7af8bf}&from=0&to=30&calories=1-5000"
        guard let url = URL(string: edamamEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let foodItem = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
                print("The todo is: " + foodItem.description)
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                guard let foodItemTitle = foodItem["label"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + foodItemTitle)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    
    @IBAction func editingCells() {
        // If the edit button title is "Done"
        retractCellsIfExtended()
        if editButton?.title == "Done"{
            // tableView is not being edited
            tableView.isEditing = false
            // Switch done button to "Edit"
            editButton?.title = "Edit"
        } else { // If the edit button title is "Edit"
            // tableView is being edited
            tableView.isEditing = true
            // Switch edit button to "Done"
            editButton?.title = "Done"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
      
        if editingStyle == .delete {
            // Delete cell at position
            tableViewData.remove(at: indexPath.row)
            //itemCount = tableViewData.count
            tableView.reloadData()
            
        
            }
        

    }
    
    
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
}
