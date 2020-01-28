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
    
    var schedule: Schedule?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = schedule?.scheduleName
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = "Back"
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setThemeTextAttributes()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissView))
        navigationController?.navigationBar.tintColor = UIColor.themeBlue()
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func donePressed() {
        //call api to change everything on backend
        dismissView()
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @objc func switchValueChanged(sender: UISwitch) {
        print(sender.isOn)
        ScheduleController.shared.setActiveState(scheduleId: schedule!.scheduleId)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.white.cgColor
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            let activeSwitch = UISwitch()
            
            activeSwitch.isOn = true // set this to schdule.isActive
            activeSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
            cell.accessoryView = activeSwitch
            
            cell.textLabel?.text = "Enable This Schedule"
        } else if indexPath.section == 1 {
            if let time = schedule?.hour {
                cell.textLabel!.text = String(time)
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
                cell.textLabel?.text = id
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
            print("push to when selector")
            let vc = WhenViewController.storyboardInitialViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.schedule = schedule
        } else if indexPath.section == 3 {
            print("add valve")
        } else if indexPath.section == 4 {
            print("test schedule")
        } else if indexPath.section == 5 {
            print("delete schedule")
        }
    }
    
    func setupTestTarget() {
        
    }
}
