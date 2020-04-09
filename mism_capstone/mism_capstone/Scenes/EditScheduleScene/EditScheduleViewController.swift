//
//  EditScheduleViewController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/28/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class EditScheduleViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var schedule: Schedule!
    var isAddingSchedule = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.separatorStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = schedule?.scheduleName
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = "Back"
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setThemeTextAttributes()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: isAddingSchedule ? "Save" : "Done", style: .done, target: self, action: #selector(donePressed))
        navigationController?.navigationBar.tintColor = UIColor.themeBlue()
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func donePressed() {
        if self.isAddingSchedule {
            ScheduleController.shared.addSchedule(schedule: schedule) { (success) in
                DispatchQueue.main.async() {
                    if !success {
                        if let navControl = self.navigationController {
                            LogInHelper.shared.signOut(navController: navControl)
                        }
                        
                    } else {
                        self.dismissView()
                    }
                }
            }
        } else {
            //call api to change everything on backend
            ScheduleController.shared.updateScheduleById(schedule: schedule)
            dismissView()
        }
    }

}

extension EditScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = UILabel()
        if section == 1 {
            title.text = "When:"
            title.font = themedFont.titleLabel
            return title
        } else if section == 2 {
            title.text = "Valves:"
            title.font = themedFont.titleLabel
            return title
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2, 3, 4, 5:
            return 1
        default:
           return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isAddingSchedule ? 4 : 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @objc func switchValueChanged(sender: UISwitch) {
        ScheduleController.shared.setActiveState(scheduleId: String(schedule!.scheduleId!))
        schedule.enabled = sender.isOn
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 5
        if #available(iOS 13.0, *) {
            cell.layer.borderColor = UIColor.systemBackground.cgColor
        } else {
            cell.layer.borderColor = UIColor.white.cgColor
        }
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            let activeSwitch = UISwitch()
            
            activeSwitch.isOn = schedule.enabled // set this to schdule.isActive
            activeSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
            cell.accessoryView = activeSwitch
            
            cell.textLabel?.text = "Enable This Schedule"
        } else if indexPath.section == 1 {
            
            if let startTime = schedule.startTime {
                cell.textLabel!.text = ScheduleController.shared.convertFromMilitaryTime(startTime: schedule.startTime!)
            } else {
                cell.textLabel!.text = "Choose start time"
            }
        
            if #available(iOS 13.0, *) {
                cell.imageView?.image = UIImage(systemName: "clock")
                cell.imageView?.tintColor = UIColor.themeBlue()
            } else {
                // Fallback on earlier versions
            }
            cell.accessoryType = .disclosureIndicator
        } else if indexPath.section == 2 {
            if let id =  schedule?.valveId {
                if id == "" {
                     cell.textLabel?.text = "No valves"
                } else {
                     cell.textLabel?.text = id
                }
            }
        } else if indexPath.section == 3 {
            cell.textLabel?.text = "Add Valves To This Schedule"
            cell.textLabel?.textColor = UIColor.themeBlue()
        } else if indexPath.section == 4 {
            cell.textLabel?.text = "Test This Schedule"
            cell.textLabel?.textColor = UIColor.themeBlue()
        } else if indexPath.section == 5 {
            cell.textLabel?.text = "Delete this schedule"
            cell.textLabel?.textColor = .red
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = WhenViewController.storyboardInitialViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.schedule = schedule
        } else if indexPath.section == 3 {
            //TODO: push to add valve page
            print("add valve")
        } else if indexPath.section == 4 {
            print("test schedule")
            testSchedule(scheduleId: String(schedule.scheduleId!))
        } else if indexPath.section == 5 {
            AlertService.shared.deleteAlert(target: self, title: "Delete \(schedule.scheduleName ?? "this schedule")?", message: "This is permanent. You will have to recreate this scheudle", completion: delete)
        }
    }
    
    func delete() {
        //TODO: call delete schedule api
        ScheduleController.shared.deleteScheduleById(schedule: schedule)
        ScheduleController.shared.deleteSchedule(controllerId: schedule.controller_id!, scheduleId: schedule.scheduleId!)
        self.dismissView()
    }
    
    func testSchedule(scheduleId: String) {
        //TODO: call test schedule api
    }
    
    func setupTestTarget() {
        
    }
}
