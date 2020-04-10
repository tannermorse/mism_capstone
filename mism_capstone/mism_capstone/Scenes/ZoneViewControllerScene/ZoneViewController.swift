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
    
    var valves = [Valve]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Zones"
        navigationController?.navigationBar.setThemeTextAttributes()
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
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(ZoneTableViewCell.self, forCellReuseIdentifier: "ZoneTableViewCell")
        tableView.separatorStyle = .none
    }
    
    func pushDetailZoneViewController(valve: Valve) {
        let vc = DetailZoneViewController.storyboardInitialViewController()
        vc.title = valve.valveName
        vc.valve = valve
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ZoneViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZoneTableViewCell", for: indexPath) as! ZoneTableViewCell
        let imageUrlString = "https://capstoneimagebucket.s3.us-east-2.amazonaws.com/images/\(valves[indexPath.row].receiverId!)/\(valves[indexPath.row].id!)/image.jpg"
        cell.configureCell(title: valves[indexPath.row].valveName!, imageUrl: imageUrlString, id: valves[indexPath.row].id!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushDetailZoneViewController(valve: valves[indexPath.row])
    }
    
}
