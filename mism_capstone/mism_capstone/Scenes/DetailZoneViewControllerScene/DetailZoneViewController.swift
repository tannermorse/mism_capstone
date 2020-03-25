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
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var testSwitch: UISwitch!
    @IBOutlet weak var testLabel: UILabel!
    
    @IBAction func addImagePressed(sender: UIButton) {
        CameraHandler.shared.presentPhotoSelectorActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            
            CameraHandler.shared.uploadImageToS3(image: image, controllerId: self.valve!.receiverId, valveId: self.valve!.id)
            /* get your image here */
            self.zoneImageView.image = image
        }
    }
    
    var valve: Valve?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleLabel.font = themedFont.titleLabel
        testLabel.font = themedFont.viewLabel
        navigationController?.navigationBar.setThemeTextAttributes()
        
        if let url = URL(string: "https://capstoneimagebucket.s3.us-east-2.amazonaws.com/images/\(valve!.receiverId)/\(valve!.id)/image.jpg") {
               zoneImageView.load(url: url, defaultImage: UIImage(named: "launchImage")!)
        }
        
        
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        tableView.separatorStyle = .none
        
        addImageButton.layer.cornerRadius = 5
        addImageButton.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        
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
        if #available(iOS 13.0, *) {
            vc.isModalInPresentation = true
        }
        let navController = UINavigationController(rootViewController: vc) // Creating a navigation
        
        self.present(navController, animated: true, completion: nil)
    }
    
    
}

struct ScheduleCell {
    static let identifier = "ScheduleTableViewCell"
}
