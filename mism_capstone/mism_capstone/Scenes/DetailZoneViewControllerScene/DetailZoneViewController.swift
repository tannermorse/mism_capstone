//
//  DetailZoneViewController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/15/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class DetailZoneViewController: UIViewController, StoryboardInstantiatable, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var zoneImageView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var testSwitch: UISwitch!
    @IBOutlet weak var testLabel: UILabel!
    
    @IBAction func addImagePressed(sender: UIButton) {
        presentPhotoSelectorActionSheet()
    }
    
    var valve: Valve?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleLabel.font = themedFont.titleLabel
        testLabel.font = themedFont.viewLabel
        navigationController?.navigationBar.setThemeTextAttributes()
        zoneImageView.load(url: URL(string: "https://images2.minutemediacdn.com/image/upload/c_fill,g_auto,h_1248,w_2220/f_auto,q_auto,w_1100/v1555274667/shape/mentalfloss/istock-498015683.jpg")!)
        
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        tableView.separatorStyle = .none
        
        addImageButton.layer.cornerRadius = 5
        addImageButton.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        
    }
    
    func presentPhotoSelectorActionSheet() {
        let actionSheet = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        let takePhotoAction = UIAlertAction(title: "Take picture", style: .default, handler: { void in
            self.openCamera()
        })
        let pickPhotoAction = UIAlertAction(title: "Choose picture from library", style: .default, handler: { void in
            self.openPhotoLibrary()
        })
        
        if #available(iOS 13.0, *) {
            let cameraImage = UIImage(systemName: "camera")
            takePhotoAction.setValue(cameraImage, forKey: "image")
            let photoImage = UIImage(systemName: "photo")
            pickPhotoAction.setValue(photoImage, forKey: "image")
            
        } else {
            // Fallback on earlier versions
        }
        
        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(pickPhotoAction)
        actionSheet.addAction(dismissAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }
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
