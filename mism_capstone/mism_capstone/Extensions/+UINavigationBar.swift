//
//  +UINavigationBar.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/15/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func setThemeTextAttributes() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.themeBlack(), NSAttributedString.Key.font: UIFont(name: "Superclarendon-Black", size: 20.0)!]
        self.titleTextAttributes = textAttributes
    }
}

struct themedFont {
    static let titleLabel = UIFont(name: "Superclarendon-Black", size: 18.0)!
    static let primaryLabel = UIFont(name: "Superclarendon-Black", size: 12.0)!
    static let secondaryLabel = UIFont(name: "Superclarendon", size: 10.0)!

}
