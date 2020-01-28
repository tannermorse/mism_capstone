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
    
    init() {
        valves = [Valve(id: "1", zoneName: "Front Yard", imageUrl: "frontyard", latitude: 2.01, longitude: 2.01, receiverId: "123", schedules: [Schedule(scheduleId: "1", scheduleName: "Morning Dew", valveId: "1", minute: 30, hour: 1, daysOfweek: [1,3,5])])]
    }
    
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
