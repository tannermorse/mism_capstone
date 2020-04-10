//
//  ValveSelectionViewController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 4/5/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class ValveSelectionViewController: UITableViewController, StoryboardInstantiatable, UINavigationControllerDelegate {
    
    var valves = [Valve]()
    var selectedValves = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Valves"
        navigationController?.delegate = self
        ValveController.shared.getReceiversByController(controllerId: 1) { (ids) in
            for i in ids {
                ValveController.shared.getValvesByController(controllerId: 1, receiverId: i) { (valves) in
                    for v in valves {
                        self.valves.append(v)
                    }
                    DispatchQueue.main.async() {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let editVC = viewController as? EditScheduleViewController {
            editVC.schedule.valveIds = selectedValves
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return valves.count > 0 ? 0 : 1
        } else {
            return valves.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.tintColor = .themeBlue()
        if indexPath.section == 0 {
            cell.textLabel?.text = "No valves to show..."
        } else {
            print(valves.count)
            cell.textLabel?.text = valves[indexPath.row].valveName!
            if selectedValves.contains(valves[indexPath.row].id!) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedValves.contains(valves[indexPath.row].id!) {
            selectedValves.removeAll(where: { $0 == valves[indexPath.row].id! })
        } else {
            selectedValves.append(valves[indexPath.row].id!)
        }
        tableView.reloadData()
    }

}
