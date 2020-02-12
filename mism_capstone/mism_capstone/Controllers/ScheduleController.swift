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
    var schedules = [Schedule(scheduleId: "1", scheduleName: "Afternoon Rinse", valveId: "1", minute: 30, hour: 13, daysOfweek: [1,2,3,5]), Schedule(scheduleId: "1", scheduleName: "Evening Extra", valveId: "1", minute: 30, hour: 19, daysOfweek: [2,4,5,6]), Schedule(scheduleId: "1", scheduleName: "Night Rade", valveId: "1", minute: 30, hour: 22, daysOfweek: [1,3,5,7])]
    
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
    
    func filteredSchedulesByDay(_ dayInt: Int? = nil) -> [Schedule] {
        if let dayValue = dayInt {
            return schedules.filter {$0.daysOfweek.contains(dayValue)}
        } else {
            return schedules.filter {$0.daysOfweek.contains(currentWeekday())}
        }
    }
    
    func currentWeekday() -> Int{
        let date = Date()
        let calender = Calendar.current
        return calender.component(.weekday, from: date)
    }
    
    func currentWeekDayName(_ day: Int? = nil) -> String {
        var switchDayValue = currentWeekday()
        if day != nil {
            if switchDayValue == day! {
                return "Today"
            } else {
                switchDayValue = day!
            }
        }
        
        switch switchDayValue {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        default:
            return "Saturday"
        }
    }
    
}
