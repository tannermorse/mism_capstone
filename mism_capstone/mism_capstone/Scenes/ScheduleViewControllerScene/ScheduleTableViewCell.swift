//
//  ScheduleCollectionViewCell.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/26/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    var outerView = UIView()
    var schedImageView = UIImageView()
    var schedStartLabel = UILabel()
    var schedNameLabel = UILabel()
    var vStack = UIStackView()
    var schedule: Schedule?
    
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
        [outerView].forEach() {self.addSubview($0)}
        [schedImageView, schedNameLabel, schedStartLabel, vStack].forEach() {outerView.addSubview($0)}
        outerView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    func configureCell(schedule: Schedule) {
        self.schedule = schedule
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        outerView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
        outerView.layer.cornerRadius = 25
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
        schedStartLabel.text = "Start time: \(startTime), Days: \(days)"
    }
    
    func setupSchedNameLabel(withName scheduleName: String) {
        schedNameLabel.font = themedFont.secondaryLabel
        schedNameLabel.text = scheduleName
    }
    

    func setupStackView() {
        vStack.configureStackView(subViews: [schedImageView, schedStartLabel, schedNameLabel], distribution: .fill, axis: .vertical, alignment: .top, spacing: 10)
        vStack.anchor(top: outerView.topAnchor, leading: outerView.leadingAnchor, trailing: outerView.trailingAnchor, bottom: outerView.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    
}
