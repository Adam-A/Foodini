//
//  IndividualListViewController.swift
//  App
//
//  Created by William Chilcote on 11/16/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class IndividualListViewController: UIViewController, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    @IBOutlet weak var table: UITableView!
    var list: ShoppingList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.reloadData()
        
        // Generate the "Add" button in the top right
        let newItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(NewItem(sender:)))
        self.navigationItem.rightBarButtonItem = newItem
        
        //DZNEmptyDataSet
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
        table.tableFooterView = UIView()
    }
    
    @objc func NewItem(sender: UIBarButtonItem){

        let alert = UIAlertController(title: "New item", message: "Add an item", preferredStyle: .alert)
        
        // Generate a text field
        alert.addTextField { (textField) in textField.text = "" }
        
        // Add the "Add" button to the alert
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if let text = alert.textFields?[0].text {
                // Append the entry to the current list
                self.list?.listItems.append(text)
                self.table.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of cells to generate
        return list?.listItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Generate cells with list contents
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") ?? UITableViewCell(style: .default, reuseIdentifier: "itemCell")
        // Set text to item name
        cell.textLabel?.text = list?.listItems[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // Delete the cell at the given index
            list?.listItems.remove(at: indexPath.row)
            tableView.reloadData()
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
