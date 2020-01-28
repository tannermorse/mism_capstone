//
//  WhenViewController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/28/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class WhenViewController: UIViewController, StoryboardInstantiatable {
    var schedule: Schedule?
    @IBOutlet var dayButtons: [UIButton]!
    var isOn = [Int]()
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBAction func durationChanged(_ sender: UISlider) {
        let step: Float = 0.25
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        durationLabel.text = "\(roundedValue)"
        durationMetricLabel.text =  "Hour(s)"
    }
    @IBOutlet weak var durationTitleLabel: UILabel!
    
    @IBOutlet weak var durationMetricLabel: UILabel!
    @IBAction func dayButtonPressed(_ sender: UIButton) {
        if isOn.contains(sender.tag) {
            dayButtons[sender.tag].backgroundColor = UIColor.white
            isOn = isOn.filter {$0 != sender.tag}
        } else {
            isOn.append(sender.tag)
            dayButtons[sender.tag].backgroundColor = .themeOrange()
        }
        schedule?.hour = 20
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Time Of Day"
        [timeLabel, repeatLabel, durationTitleLabel].forEach() { label in
            label.font = themedFont.titleLabel
        }
        [durationMetricLabel, durationLabel].forEach() { label in
            label.font = themedFont.viewLabel
        }
        
        durationSlider.tintColor = UIColor.themeBlue()
        setupButtons()
    }
    
    func setupButtons() {
        for button in dayButtons {
            button.layer.cornerRadius = button.frame.width / 2
            button.setTitleColor(UIColor.themeBlue(), for: .normal)
            button.layer.borderColor = UIColor.themeBlue().cgColor
            button.layer.borderWidth = 1
            
            if (schedule?.daysOfweek.contains(button.tag))! {
                button.backgroundColor = .themeOrange()
                isOn.append(button.tag)
            }
        }
    }

}
