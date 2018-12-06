//
//  RecipesViewController.swift
//  App
//
//  Created by Adam Ali on 11/18/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
    
}

class RecipesViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    @IBOutlet var recipeTableView: UITableView!
    @IBOutlet weak var rouletteButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    var tableViewData = [cellData]()
    override func viewDidLoad() {
    super.viewDidLoad()
        
        //TEST DATA
        tableViewData = [cellData(opened: false, title: "Rice and Beans", sectionData: ["Rice", "Beans", "Salt"]),cellData(opened: false, title: "Curry Chicken", sectionData: ["Curry", "Chicken"]),cellData(opened: false, title: "Mac n Cheese", sectionData: ["Mac", "Cheese"])]
        
        //DZNEmptyDataSet
        recipeTableView.emptyDataSetSource = self
        recipeTableView.emptyDataSetDelegate = self
        recipeTableView.tableFooterView = UIView()
        
        
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
        
        DispatchQueue.global(qos: .background).async {
            let theMealDBEndpoint: String = "http://www.themealdb.com/api/json/v1/1/random.php"
            guard let url = URL(string: theMealDBEndpoint) else { return }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let dataResponse = data,
                    error == nil else {
                        print(error?.localizedDescription ?? "Response Error")
                        return }
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        dataResponse, options: [])
                    guard let jsonArray = jsonResponse as? [String: Any] else {
                        return
                    }
                    var recipe = Recipe()
              
                    let jsonDict = jsonArray.first?.value as? [[String:Any]]
                    var cd = cellData.init()
                    for item in (jsonDict?.first)! {
                        if (item.key.starts(with: "strMeasure") || item.key.starts(with: "strIngredient")) {
                        recipe.apiMap[item.key] = item.value as? String
                        }
                        if (item.key == "strMeal") {
                            cd.title = item.value as! String
                        }
                    }
                    for n in 1...20 {
                        let measure = recipe.apiMap[ "strMeasure\(n)"]
                        let ingredient = recipe.apiMap[ "strIngredient\(n)"]
                        let sectionDataString = "\(measure ?? "") \(ingredient ?? "")"
                        if (!sectionDataString.isEmpty && sectionDataString.count > 3) {
                        cd.sectionData.append(sectionDataString)
                        }
                    }
                    cd.opened = false
                    self.tableViewData.append(cd)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
            
          
        }
 
       
        
        
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
            cell.textLabel?.text = "  \u{2022} \(tableViewData[indexPath.section].sectionData[dataIndex])"

            
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
    
    //-----DZNEmptyDataSet cocoapod use -----
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let title = "Welcome To Your Recipe Book"
        let Attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: title, attributes: Attributes)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "RecipeEmptyState")
    }
}


struct Recipe {
    var strMeal = String()
    var strInstructions = String()
    
    var apiMap = [
        "strIngredient1" : "",
        "strIngredient2" : "",
        "strIngredient3" : "",
        "strIngredient4" : "",
        "strIngredient5" : "",
        "strIngredient6" : "",
        "strIngredient7" : "",
        "strIngredient8" : "",
        "strIngredient9" : "",
        "strIngredient10" : "",
        "strIngredient11" : "",
        "strIngredient12" : "",
        "strIngredient13" : "",
        "strIngredient14" : "",
        "strIngredient15" : "",
        "strIngredient16" : "",
        "strIngredient17" : "",
        "strIngredient18" : "",
        "strIngredient19" : "",
        "strIngredient20" : "",
        
        "strMeasure1" : "",
        "strMeasure2" : "",
        "strMeasure3" : "",
        "strMeasure4" : "",
        "strMeasure5" : "",
        "strMeasure6" : "",
        "strMeasure7" : "",
        "strMeasure8" : "",
        "strMeasure9" : "",
        "strMeasure10" : "",
        "strMeasure11" : "",
        "strMeasure12" : "",
        "strMeasure13" : "",
        "strMeasure14" : "",
        "strMeasure15" : "",
        "strMeasure16" : "",
        "strMeasure17" : "",
        "strMeasure18" : "",
        "strMeasure19" : "",
        "strMeasure20" : "",
    ]
    
}

extension Array where Element == [String:String] {
    func sorted(by key: String) -> [[String:String]] {
        return sorted { $0[key] ?? "" < $1[key] ?? "" }
    }
}
