//
//  AlertService.swift
//  mism_capstone
//
//  Created by Tanner Morse on 2/11/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import Foundation
import UIKit


class AlertService {
    static let shared = AlertService()
    
    func deleteAlert(target: UIViewController, title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { ACTION in
            completion?()
        }))
        target.present(alert, animated: true, completion: nil)
    }
}
