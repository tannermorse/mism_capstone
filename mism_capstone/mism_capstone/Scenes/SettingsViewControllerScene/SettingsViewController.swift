//
//  SettingsViewController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/15/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit
import AWSAuthUI

class SettingsViewController: UIViewController, StoryboardInstantiatable {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }

    func signOut(){
        AWSSignInManager.sharedInstance().logout { (anyObj: Any?, errorObj: Error?) in
            print("signed out!");
        }
    }

}
