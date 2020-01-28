//
//  ScheduleController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/26/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import Foundation

class ScheduleController {
    static let shared = ScheduleController()
    var schedules = [Schedule]()
    
    func getSchedulesById(id: String) -> [Schedule] {
        return schedules.filter { $0.valveId == id }
    }
    
    func addScheduleToValve(valveIds: [String], minute: Int, hour: Int, AmOrPm: String) {
        // send to api info to create a schedule
    }
    
    func deleteSchedule(valveIds: [String], scheduleId: String) {
        // send to api info to delete a schedule
        //DELETE
    }
    
    func setActiveState(scheduleId: String) {
        
    }
    
}
