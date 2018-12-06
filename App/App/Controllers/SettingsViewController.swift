//
//  SettingsViewController.swift
//  App
//
//  Created by Adam Ali on 11/18/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//

import UIKit
import MessageUI

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

    
    @IBAction func onContactUsPress(_ sender: Any) {
        UIApplication.shared.open(URL(string: "mailto:support@canigraduatealready.com")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func onFeedbackPress(_ sender: Any){
          UIApplication.shared.open(URL(string: "mailto:feedback@canigraduatealready.com")! as URL, options: [:], completionHandler: nil)
        
    }
}
