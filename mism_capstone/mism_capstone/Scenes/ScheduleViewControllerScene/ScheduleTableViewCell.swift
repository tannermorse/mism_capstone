//
//  ScheduleCollectionViewCell.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/26/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    var schedImageView = UIImageView()
    var schedStartLabel = UILabel()
    var schedDurationLabel = UILabel()
    var schedNameLabel = UILabel()
    var vStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func addSubviews() {
        func addSubviews() {
            [schedImageView, schedNameLabel, schedStartLabel, schedDurationLabel, vStack].forEach() {self.addSubview($0)}
        }
    }
    
    func configureCell(schedule: Schedule) {
        self.accessoryType = .disclosureIndicator
        backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
        setupSchedImageView(image: getTimeOfDayImage(hour: schedule.hour))
        setupSchedStartLabel(startTime: String(schedule.hour), days: schedule.daysOfweek[0])
        setupSchedNameLabel(withName: schedule.scheduleName)
        setupStackView()
        
    }
    
    func getTimeOfDayImage(hour: Int) -> String {
        if hour > 0 && hour <= 5 {
            return "moon"
        } else if hour >= 6 && hour <= 9 {
            return "sunrise"
        } else if hour >= 10 && hour <= 18 {
            return "midday"
        } else if hour >= 19 && hour <= 20 {
            return "sunset"
        } else {
            return "moon"
        }
    }
    
    func setupSchedImageView(image: String) {
        schedImageView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: nil, centerY: nil, size: .init(width: 44, height: 44))
        schedImageView.image = UIImage(named: image)
    }
    
    func setupSchedStartLabel(startTime: String, days: Int) {
        schedStartLabel.font = themedFont.primaryLabel
        schedStartLabel.text = "\(startTime) \(days)"
    }
    
    func setupSchedNameLabel(withName scheduleName: String) {
        schedNameLabel.font = themedFont.secondaryLabel
        schedDurationLabel.text = scheduleName
    }
    

    func setupStackView() {
        vStack.configureStackView(subViews: [schedImageView, schedNameLabel, schedStartLabel, schedDurationLabel], distribution: .fillProportionally, axis: .vertical, alignment: .top, spacing: 10)
        vStack.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    
}
