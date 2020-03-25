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
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zoneCells.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZoneTableViewCell", for: indexPath) as! ZoneTableViewCell
        let imageUrlString = "https://capstoneimagebucket.s3.us-east-2.amazonaws.com/images/\(String(indexPath.row))/\(String(indexPath.row))/image.jpg"
        cell.configureCell(title: zoneCells[indexPath.row].title, imageUrl: imageUrlString, id: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pushDetailZoneViewController(valve: Valve(id: String(indexPath.row), zoneName: "Front Yard", imageUrl: "frontyard", latitude: 2.01, longitude: 2.01, receiverId: String(indexPath.row), schedules: []))
    }
    
    
}
