//
//  WhenViewController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/28/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class WhenViewController: UIViewController, StoryboardInstantiatable, UINavigationControllerDelegate {
    var schedule: Schedule?
    @IBOutlet var dayButtons: [UIButton]!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func startTimeChanged(_ sender: UIDatePicker) {
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        schedule?.startTime = df.string(from: sender.date)
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let editVC = viewController as? EditScheduleViewController {
            editVC.schedule = schedule
        }
    }
    
    var isOn = [Int]()
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBAction func durationChanged(_ sender: UISlider) {
        let step: Float = 1.0
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        durationLabel.text = "\(Int(roundedValue))"
        durationMetricLabel.text =  "Minutes"
        schedule!.duration = roundedValue
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
        
        schedule?.daysOfweek = isOn.sorted()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        title = "Time Of Day"
        [timeLabel, repeatLabel, durationTitleLabel].forEach() { label in
            label.font = themedFont.titleLabel
        }
        [durationMetricLabel, durationLabel].forEach() { label in
            label.font = themedFont.viewLabel
        }
        
        setCurrentTime()
        durationSlider.tintColor = UIColor.themeBlue()
        if let duration = schedule?.duration {
            durationSlider.value = duration
            durationLabel.text = "\(Int(duration))"
        }
        setupButtons()
    }
    
    func setCurrentTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        if let date = dateFormatter.date(from: schedule!.startTime!) {
            timePicker.setDate(date, animated: true)
        }
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
