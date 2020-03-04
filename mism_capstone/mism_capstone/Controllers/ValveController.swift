//
//  ValveController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/26/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import Foundation

class ValveController {
    static let shared = ValveController()
    
    var valves = [Valve]()
    
    
    func switchValveState(id: String) {
        // send to api to switch the state of the valve
    }
    
    func updateImage(image: Data) {
        //POST
    }
    
    func updateValveName(valveId: String, newName: String) {
        //POST
    }
    
}
