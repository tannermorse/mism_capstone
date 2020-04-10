//
//  ScheduleViewController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/6/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let scheduleUpdate = Notification.Name("scheduleUpdate")
}

class ScheduleViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentDay = 0
    var schedules = [Schedule]()
    let scheduleController = ScheduleController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let navigationController = self.navigationController {
            LogInHelper.shared.showSignIn(navController: navigationController)
        }
        title = "Today's Schedule"
        currentDay = scheduleController.currentWeekday()
        schedules = scheduleController.filteredSchedulesByDay()
        navigationController?.navigationBar.setThemeTextAttributes()
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        setupNavButtons()
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData), name: .scheduleUpdate, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .scheduleUpdate, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNotifications()
        scheduleController.getSchedulesByController(controllerId: 1)
    }
    
    @objc func reloadTableData() {
        DispatchQueue.main.sync {
            self.schedules = ScheduleController.shared.filteredSchedulesByDay(self.currentDay)
            self.tableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let addScheduleButton = UIButton()
    
        view.addSubview(addScheduleButton)
        addScheduleButton.anchor(top: nil, leading: nil, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: view.centerYAnchor, size: .init(width: 44, height: 44))
        if #available(iOS 13.0, *) {
            let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
            addScheduleButton.setImage(UIImage(systemName: "calendar.badge.plus", withConfiguration: largeConfiguration), for: .normal)
        } else {
            addScheduleButton.setTitle("Add Schedule", for: .normal)
        }
        
        addScheduleButton.addTarget(self, action: #selector(addSchedulePressed), for: .touchUpInside)
        return view
    }
    
    @objc func addSchedulePressed() {
        //present add schdule capability
        let newSchedule = Schedule(controller_id: 1, scheduleName: "", valveIds: [], startTime: "18:00:00", daysOfweek: [currentDay], duration: 15, enabled: true)
        presentPresentEditScheduleController(schedule: newSchedule, isAddingSchedule: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count != 0 ? schedules.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if schedules.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.identifier, for: indexPath) as! ScheduleTableViewCell
            cell.configureCell(schedule: schedules[indexPath.row])
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "There are no schedules running today..."
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if schedules.count != 0 {
            presentPresentEditScheduleController(schedule: schedules[indexPath.row], isAddingSchedule: false)
        }
    }
    
    func presentPresentEditScheduleController(schedule: Schedule, isAddingSchedule: Bool) {
        let vc = EditScheduleViewController.storyboardInitialViewController()
        vc.schedule = schedule
        vc.isAddingSchedule = isAddingSchedule
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }

}
