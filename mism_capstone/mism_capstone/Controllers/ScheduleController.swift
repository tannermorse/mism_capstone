//
//  ScheduleController.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/26/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import Foundation
import AWSAuthCore

class ScheduleController {
    static let shared = ScheduleController()
    var schedules : [Schedule] = [] {
           didSet{
                NotificationCenter.default.post(name: .scheduleUpdate, object: nil)
           }
       }
    
    init() {}
    
    func getSchedulesByValveId(id: Int) -> [Schedule] {
        return schedules.filter { $0.valveIds.contains(id) }
    }
    
    func addScheduleToValve(valveIds: [String], minute: Int, hour: Int, AmOrPm: String) {
        // send to api info to create a schedule
    }
    
    func deleteSchedule(controllerId: Int, scheduleId: Int) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "https://0z02zemtz2.execute-api.us-east-2.amazonaws.com/Development/controllers/\(controllerId)/schedules/\(scheduleId)")!,timeoutInterval: 10)
        request.httpMethod = "DELETE"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    print("Delete Status code: \(httpResponse.statusCode)")
                }
            }
        })
            task.resume()
    }
    
    func setActiveState(scheduleId: String) {
        
    }
    
    func updateScheduleById(schedule: Schedule) {
        if let row = self.schedules.firstIndex(where: {$0.scheduleId! == schedule.scheduleId!}) {
               schedules[row] = schedule
            self.updateSchedule(schedule: schedule)
        }
    }
    
    func deleteScheduleById(schedule: Schedule) {
        if let row = self.schedules.firstIndex(where: {$0.scheduleId! == schedule.scheduleId!}) {
            schedules.remove(at: row)
        }
    }
    
    func filteredSchedulesByDay(_ dayInt: Int? = nil) -> [Schedule] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        if let dayValue = dayInt {
            var schedulesSortedByDate = schedules.filter {$0.daysOfweek.contains(dayValue)}
            schedulesSortedByDate.sort { dateFormatter.date(from: $0.startTime!)! < dateFormatter.date(from: $1.startTime!)! }
            return schedulesSortedByDate
        } else {
            var sched = schedules.filter {$0.daysOfweek.contains(currentWeekday())}
            sched.sort { dateFormatter.date(from: $0.startTime!)! < dateFormatter.date(from: $1.startTime!)! }
            return sched
        }
    }
    
    func currentWeekday() -> Int{
        let date = Date()
        let calender = Calendar.current
        return calender.component(.weekday, from: date) - 1
    }
    
    func getShortWeekDays(days: [Int]) -> String {
        let calender = Calendar.current
        var daysString = ""
        for day in days {
            daysString += "\(calender.shortWeekdaySymbols[day]), "
        }
        if daysString != "" {
            daysString = String(daysString.dropLast(2))
        }
        return daysString
    }
    
    func currentWeekDayName(_ day: Int? = nil) -> String {
        let currentDayValue = currentWeekday()
        let calender = Calendar.current
        if day != nil {
            if currentDayValue == day! {
                return "Today"
            }
        }
        return calender.standaloneWeekdaySymbols[day!]
    }
    
    func convertFromMilitaryTime(startTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        if let date = dateFormatter.date(from: startTime) {
            dateFormatter.dateFormat = "h:mm a"
             return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    func getSchedulesByController(controllerId: Int) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "https://0z02zemtz2.execute-api.us-east-2.amazonaws.com/Development/controllers/\(controllerId)/schedules/")!,timeoutInterval: 10)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let status = response as? HTTPURLResponse {
                print(status.statusCode)
            }
            if error != nil {
                print(error!)
            } else {
                do {
                    self.schedules = try JSONDecoder().decode([Schedule].self, from: data!)
                    for (index, schedule) in self.schedules.enumerated() {
                        ValveController.shared.getValvesBySchedule(controllerId: controllerId, scheduleId: schedule.scheduleId!) { (valves) in
                            for valve in valves {
                                if let id = valve.id {
                                    self.schedules[index].valveIds.append(id)
                                }
                            }
                        }
                    }
                } catch {
                    print("could not serialize schedule data")
                }

            }
        })
            task.resume()
    }
    
    func updateScheduledDays(schedule: Schedule) -> Schedule {
        var tempSchedule = Schedule(controller_id: schedule.controller_id!, scheduleName: schedule.scheduleName ?? "", valveIds: schedule.valveIds, startTime: schedule.startTime!, daysOfweek: schedule.daysOfweek, duration: schedule.duration!, enabled: schedule.enabled)
        
        for i in schedule.daysOfweek {
            switch i {
            case 0:
                tempSchedule.sunday = true
            case 1:
                tempSchedule.monday = true
            case 2:
                tempSchedule.tuesday = true
            case 3:
                tempSchedule.wednesday = true
            case 4:
                tempSchedule.thursday = true
            case 5:
                tempSchedule.friday = true
            default:
                tempSchedule.saturday = true
            }
        }
        
        return tempSchedule
    }
    
    func addSchedule(schedule: Schedule, completion: @escaping (Bool) -> Void) {
        schedules.append(schedule)
        
        //checking that the user token is stored in UserDefaults
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            if let url = URL(string: "https://0z02zemtz2.execute-api.us-east-2.amazonaws.com/Development/controllers/\(schedule.controller_id!)/schedules") {
                
                var request = URLRequest(url: url, timeoutInterval: 10)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = updateScheduledDays(schedule: schedule).encodedJsonBody()
                request.addValue(token, forHTTPHeaderField: "Authorizer")
                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    if let r = response as? HTTPURLResponse {
                        // do something like a fading pop up that says you schedule was adding
                        print(r.statusCode)
                        r.statusCode != 200 ? completion(false) : completion(true)
                    }
                })
                task.resume()
                
            }
        }
    }
    
    func updateSchedule(schedule: Schedule) {
        if let url = URL(string: "https://0z02zemtz2.execute-api.us-east-2.amazonaws.com/Development/controllers/\(schedule.controller_id!)/schedules/\(schedule.scheduleId!)") {
            
            var request = URLRequest(url: url, timeoutInterval: 10)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = updateScheduledDays(schedule: schedule).encodedJsonBody()
            
            
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if let r = response as? HTTPURLResponse {
                    // do something like a fading pop up that says you schedule was adding
                    print(r.statusCode)
                }
            })
            task.resume()
            
        }
    }
    
}
