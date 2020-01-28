//
//  DetailZoneViewController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/15/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class DetailZoneViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet weak var zoneImageView: UIImageView!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var valve: Valve?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleLabel.font = themedFont.titleLabel
        navigationController?.navigationBar.setThemeTextAttributes()
        zoneImageView.load(url: URL(string: "https://images2.minutemediacdn.com/image/upload/c_fill,g_auto,h_1248,w_2220/f_auto,q_auto,w_1100/v1555274667/shape/mentalfloss/istock-498015683.jpg")!)
        
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        tableView.separatorStyle = .none
    }
    

    
    func setupEditButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editPressed))
    }
    
    @objc func editPressed() {
        //TODO: add functionality to edit zone
    }


}

extension DetailZoneViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valve?.schedules.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.identifier, for: indexPath) as! ScheduleTableViewCell
        cell.configureCell(schedule: (valve?.schedules[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditScheduleViewController.storyboardInitialViewController()
        vc.schedule = valve?.schedules[indexPath.row]
        let navController = UINavigationController(rootViewController: vc) // Creating a navigation

        self.present(navController, animated: true, completion: nil)
    }
    
    
}

struct ScheduleCell {
    static let identifier = "ScheduleTableViewCell"
}
