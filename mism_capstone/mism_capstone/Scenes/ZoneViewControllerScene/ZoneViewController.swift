//
//  ZoneViewController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/8/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class ZoneViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var zoneCells = [AccountCellInfo(title: "Front Yard", icon: "frontyard"), AccountCellInfo(title: "Back Yard", icon: "backyard")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Zones"
        navigationController?.navigationBar.setThemeTextAttributes()

        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(ZoneTableViewCell.self, forCellReuseIdentifier: "ZoneTableViewCell")
        tableView.separatorStyle = .none
    }
    
    func pushDetailZoneViewController(valve: Valve) {
        let vc = DetailZoneViewController.storyboardInitialViewController()
        vc.title = valve.zoneName
        vc.valve = valve
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ZoneViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zoneCells.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZoneTableViewCell", for: indexPath) as! ZoneTableViewCell
        cell.configureCell(title: zoneCells[indexPath.row].title, imageUrl: zoneCells[indexPath.row].icon, id: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushDetailZoneViewController(valve: Valve(id: "1", zoneName: "Front Yard", imageUrl: "frontyard", latitude: 2.01, longitude: 2.01, receiverId: "123", schedules: [Schedule(scheduleId: "1", scheduleName: "Morning Dew", valveId: "1", minute: 30, hour: 6, daysOfweek: [2,3,5]), Schedule(scheduleId: "1", scheduleName: "Afternoon Rinse", valveId: "1", minute: 30, hour: 13, daysOfweek: [2,3,5]), Schedule(scheduleId: "1", scheduleName: "Evening Extra", valveId: "1", minute: 30, hour: 19, daysOfweek: [2,3,5]), Schedule(scheduleId: "1", scheduleName: "Night Rade", valveId: "1", minute: 30, hour: 22, daysOfweek: [2,3,5])]))
    }
    
    
}
