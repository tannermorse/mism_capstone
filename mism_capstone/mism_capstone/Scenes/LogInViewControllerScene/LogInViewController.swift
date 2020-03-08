//
//  LogInViewController.swift
//  mism_capstone
//
//  Created by Parker Bronson on 2/24/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit
import AWSAuthCore
import AWSAuthUI

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        showSignIn()
    }
    
    func showSignIn(){
        
        AWSSignInManager.sharedInstance().logout { (anyObj: Any?, errorObj: Error?) in
            print("signed out!");
        }
        
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            AWSAuthUIViewController.presentViewController(with: self.navigationController!, configuration: buildUIConfig(), completionHandler: {
                    (provider: AWSSignInProvider, error: Error?) in
                    if error != nil {
                        print("Error occurred: \(String(describing: error))")
                    } else {
                        print("Logged in with provider: \(provider.identityProviderName) with Token: \(provider.token())")
                        self.pushMain()
                    }
            })
        } else {
            pushMain()
        }
    }
    
    func buildUIConfig() -> AWSAuthUIConfiguration {
        
        let buttonImage = #imageLiteral(resourceName: "launchImage")
        let backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.2156862745, blue: 0.2431372549, alpha: 1)
        
        //config for UI display
        let config = AWSAuthUIConfiguration()
        config.enableUserPoolsUI = true
        //config.addSignInButtonView(class: AWSFacebookSignInButton.self)
        //config.addSignInButtonView(class: AWSGoogleSignInButton.self)
        config.backgroundColor = backgroundColor
        config.font = UIFont (name: "Helvetica Neue", size: 14)
        //config.isBackgroundColorFullScreen = true
        //config.canCancel = true
        config.logoImage = buttonImage
        
        return config
    }
    
    func pushMain() {
        
        let mainVC = MainViewController.storyboardInitialViewController()
        navigationController?.pushViewController(mainVC, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
}


