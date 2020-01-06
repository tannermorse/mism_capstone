//
//  MainViewController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/6/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, StoryboardInstantiatable {

    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "main"
        view.backgroundColor = UIColor.themeRed()
        addSubViews()
        createButton()
        
    }
    
    func addSubViews() {
        [button].forEach() {view.addSubview($0)}
    }
    
    func createButton() {
        button.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: view.centerXAnchor, centerY: view.centerYAnchor, size: .init(width: 300, height: 100))
        button.addTarget(self, action: #selector(pushScheduleViewController), for: .touchUpInside)
        button.setTitle("go to schedule", for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.themeBlue().cgColor
        button.layer.borderWidth = 2
        button.backgroundColor = UIColor.themeBlack()
    }
    

    @objc func pushScheduleViewController() {
        let vc = ScheduleViewController.storyboardInitialViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

