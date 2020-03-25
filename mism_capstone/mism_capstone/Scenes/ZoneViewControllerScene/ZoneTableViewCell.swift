//
//  ZoneTableViewCell.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/15/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit
import WebKit

class ZoneTableViewCell: UITableViewCell {
    
    let outerView = UIView()
    let zoneImage = UIImageView()
    let zoneTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    func configureCell(title: String, imageUrl: String, id: Int) {
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        outerView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
        outerView.layer.cornerRadius = 25
        setupZoneTitle(title: title)
        setupImageView(imageUrl: imageUrl)
    }
    
    func addSubviews() {
        [outerView, zoneImage, zoneTitle].forEach() {self.addSubview($0)}
        outerView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        outerView.addSubview(zoneImage)
        outerView.addSubview(zoneTitle)
    }
    
    func setupImageView(imageUrl: String) {
        zoneImage.anchor(top: nil, leading: outerView.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: outerView.centerYAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10),size: .init(width: 70, height: 70))
    
        if let url = URL(string: imageUrl) {
               zoneImage.load(url: url, defaultImage: UIImage(named: "launchImage")!)
        }
        zoneImage.clipsToBounds = true
        zoneImage.layer.cornerRadius = 35
        zoneImage.isUserInteractionEnabled = false
    }
    
    func setupZoneTitle(title: String) {
        zoneTitle.anchor(top: nil, leading: self.zoneImage.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: centerYAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        zoneTitle.text = title
        zoneTitle.font = UIFont(name: "Superclarendon-Black", size: 18.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
