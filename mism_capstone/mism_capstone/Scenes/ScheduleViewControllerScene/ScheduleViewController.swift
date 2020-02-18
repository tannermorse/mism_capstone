//
//  ScheduleViewController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/6/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentDay = ScheduleController.shared.currentWeekday()
    var schedules: [Schedule]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Today's Schedule"
        navigationController?.navigationBar.setThemeTextAttributes()
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        schedules = ScheduleController.shared.filteredSchedulesByDay()
        setupNavButtons()
    }
    
    func setupNavButtons() {
        if #available(iOS 13.0, *) {
            let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(changeDay(addDay:)))
            leftButton.tag = 1
            navigationItem.leftBarButtonItem = leftButton
            
            let rightButton = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: self, action: #selector(changeDay(addDay:)))
            leftButton.tag = 2
            navigationItem.rightBarButtonItem = rightButton
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func changeDay(addDay: UIBarButtonItem) {
        if addDay.tag == 2 {
            if currentDay == 0 {
                currentDay = 6
            } else {
                currentDay -= 1
            }
        } else {
            if currentDay == 6 {
                currentDay = 0
            } else {
                currentDay += 1
            }
        }
        title = "\(ScheduleController.shared.currentWeekDayName(currentDay))'s Schedule"
        schedules = ScheduleController.shared.filteredSchedulesByDay(currentDay)
        tableView.reloadData()
    }
    
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.identifier, for: indexPath) as! ScheduleTableViewCell
        cell.configureCell(schedule: schedules[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let vc = EditScheduleViewController.storyboardInitialViewController()
        vc.schedule = schedules[indexPath.row]
        if #available(iOS 13.0, *) {
            vc.isModalInPresentation = true
        }
        let navController = UINavigationController(rootViewController: vc) // Creating a navigation
        
        self.present(navController, animated: true, completion: nil)
    }

    
}
