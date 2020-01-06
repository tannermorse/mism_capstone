//
//  +UIStoryboard.swift
//  Final_Exam_Morse_Tanner
//
//  Created by Tanner Morse on 12/16/19.
//  Copyright © 2019 Tanner Morse. All rights reserved.
//

import UIKit

protocol StoryboardInstantiatable {
    static var defaultStoryboardName: String { get }
}

extension StoryboardInstantiatable where Self: UIViewController {
    static var defaultStoryboardName: String { return String(describing: self) }
    
    static func storyboardInitialViewController() -> Self {
        let storyboard = UIStoryboard(name: defaultStoryboardName, bundle: nil)
        
        guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Could not instantiate initial storyboard with name: \(defaultStoryboardName)")
        }
        
        return viewController
    }
}
