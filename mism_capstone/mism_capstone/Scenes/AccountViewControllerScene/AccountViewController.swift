//  AccountViewController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/8/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var accountNames = ["ben", "jerry"]
    var accountCells = [AccountCellInfo(title: "Settings", icon: "gear"), AccountCellInfo(title: "Sign out", icon: "escape")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account"
        navigationController?.navigationBar.setThemeTextAttributes()
        addSubViews()
        setupTableView()
        accountNames.append(String(accountNames.first! + "jones"))
    }
    
    func setupTableView() {
        
    }
    
    func addSubViews() {
        [].forEach() {view.addSubview($0)}
    }

    
    func pushSettingsViewController() {
        let vc = SettingsViewController.storyboardInitialViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "string")
        cell.selectionStyle = .none
        if #available(iOS 13.0, *) {
            cell.imageView?.image = UIImage(systemName: accountCells[indexPath.row].icon)
        }
        if indexPath.row == 0 {
            cell.accessoryType = .disclosureIndicator
        }
        cell.textLabel?.text = accountCells[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            pushSettingsViewController()
        }
    }
    
    
}

struct AccountCellInfo {
    var title: String
    var icon: String
}
