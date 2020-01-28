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
    
    let zoneImage = WKWebView()
    let zoneTitle = UILabel()
    let zoneSwitch = UISwitch()
    let zoneStackView = UIStackView()
    let stackViewTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    func configureCell(title: String, imageUrl: String, id: Int) {
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        setupZoneTitle(title: title)
        setupImageView(imageUrl: imageUrl)
        setupStackView()
        zoneSwitch.tag = id
    }
    
    func addSubviews() {
        [zoneImage, zoneTitle, zoneSwitch, zoneStackView].forEach() {self.addSubview($0)}
    }
    
    func setupImageView(imageUrl: String) {
        zoneImage.anchor(top: zoneTitle.bottomAnchor, leading: self.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 10, left: 10, bottom: 10, right: 10),size: .init(width: 70, height: 70))
        let request = URLRequest(url: URL(string: "https://images2.minutemediacdn.com/image/upload/c_fill,g_auto,h_1248,w_2220/f_auto,q_auto,w_1100/v1555274667/shape/mentalfloss/istock-498015683.jpg")!)
        zoneImage.load(request)
        zoneImage.contentMode = .center
        zoneImage.clipsToBounds = true
        zoneImage.layer.cornerRadius = 35
        zoneImage.isUserInteractionEnabled = false
    }
    
    func setupZoneTitle(title: String) {
        zoneTitle.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        zoneTitle.text = title
        zoneTitle.font = UIFont(name: "Superclarendon-Black", size: 18.0)
    }
    
    func setupStackView() {
        zoneStackView.anchor(top: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        zoneStackView.configureStackView(subViews: [stackViewTitle, zoneSwitch], distribution: .equalCentering, axis: .horizontal, alignment: .fill, spacing: 10)
        stackViewTitle.text = "Test Zone"
        addSwitchTarget()
    }
    
    func addSwitchTarget() {
        zoneSwitch.addTarget(self, action: #selector(switchDidChange(sender:)), for: .valueChanged)
    }

    @objc func switchDidChange(sender: UISwitch) {
        print(sender.tag)
        //TODO: function from model that starts a zone
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
