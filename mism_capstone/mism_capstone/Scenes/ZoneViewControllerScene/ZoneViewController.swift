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
    
    func pushDetailZoneViewController(zone: Zone) {
        let vc = DetailZoneViewController.storyboardInitialViewController()
        vc.title = zone.title
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
        cell.configureCell(title: zoneCells[indexPath.row].title, image: zoneCells[indexPath.row].icon, id: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushDetailZoneViewController(zone: Zone(id: String(indexPath.row),title: zoneCells[indexPath.row].title, valve: [Valve(title: "Valve 1")]))
    }
    
    
}
