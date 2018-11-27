//
//  SettingsViewController.swift
//  App
//
//  Created by Adam Ali on 11/18/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var darkThemeToggle: UISwitch!
    
    @IBOutlet weak var colorBlindModeToggle: UISwitch!
    @IBOutlet weak var largeFontToggle: UISwitch!
    @IBOutlet weak var pushNotificationToggle: UISwitch!
    @IBOutlet weak var syncToCloudButton: UIButton!
//    @IBOutlet weak var listsViewButton: UIButton!
//    @IBOutlet weak var pantryViewButton: UIButton!
//    @IBOutlet weak var RecipesViewButton: UIButton!
//    @IBOutlet weak var settingsViewButton: UIButton!
    @IBOutlet weak var contactUsButton: UIButton!
    @IBOutlet weak var feedbackButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
//         settingsViewButton.isEnabled = false

    }
    
    
    @IBAction func onPantryPress(_ sender: Any) {
        // Save data before transferring
        self.navigationItem.hidesBackButton = false;
//        settingsViewButton.isEnabled = true
        // Create the pantry VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PantryViewController") as! PantryViewController
        //viewController.delegate = self
        // Push current VC onto backstack
        self.navigationController?.pushViewController(viewController, animated: false)
        
    }
    
    @IBAction func onRecipePress(_ sender: Any) {
        // Save data before transferring
        
         // Create the pantry VC
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: "RecipesViewController") as! RecipesViewController
         //viewController.delegate = self
         // Push current VC onto backstack
         self.navigationController?.pushViewController(viewController, animated: false)
        
    }
    
    @IBAction func onListsPress(_ sender: Any) {
        // Save data before transferring
        self.navigationItem.hidesBackButton = false;
//        settingsViewButton.isEnabled = true
        // Create the pantry VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "shoppingListViewController") as! ShoppingListViewController
        //viewController.delegate = self
        //Push current VC onto backstack
        self.navigationController?.pushViewController(viewController, animated: false)
        
    }
    
    
}
