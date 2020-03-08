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

class LogInHelper {

    static let shared = LogInHelper()
    
    func showSignIn(navController: UINavigationController){
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            AWSAuthUIViewController.presentViewController(with: navController, configuration: buildUIConfig(), completionHandler: {
                    (provider: AWSSignInProvider, error: Error?) in
                    if error != nil {
                        print("Error occurred: \(String(describing: error))")
                    } else {
                        print("Logged in with provider: \(provider.identityProviderName) with Token: \(provider.token())")
                        navController.dismiss(animated: true, completion: nil)
                    }
            })
        } else {
            navController.dismiss(animated: true, completion: nil)
        }
    }
    
    func signOut(navController: UINavigationController){
        AWSSignInManager.sharedInstance().logout { (anyObj: Any?, errorObj: Error?) in
            print("logged out")
        }
        
        LogInHelper.shared.showSignIn(navController: navController)
        
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
}


