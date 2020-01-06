//
//  +UIStackView.swift
//  Final_Exam_Morse_Tanner
//
//  Created by Tanner Morse on 12/16/19.
//  Copyright © 2019 Tanner Morse. All rights reserved.
//

import UIKit

extension UIStackView {
    func configureStackView(subViews: [UIView], distribution: UIStackView.Distribution, axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, spacing: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = distribution
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        subViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
    }
}
