//
//  Schedule.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/15/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import Foundation

struct ArrayOfSchedules: Codable {
    var results: [Schedule]
    init(from decoder: Decoder) throws {
        do {
            
            var container = try decoder.unkeyedContainer()
            self.results = try container.decode([Schedule].self)
        } catch {
            print(error)
            self.results = []
        }
    }


}

struct Schedule: Codable {
    var controller_id: Int?
    var scheduleId: Int?
    var scheduleName: String?
    var valves: [Valve] = []
    var startTime: String?
    var monday = false
    var tuesday = false
    var wednesday = false
    var thursday = false
    var friday = false
    var saturday = false
    var sunday = false
    var daysOfweek = [Int]()
    var duration: Float?
    var enabled = true
    
    init(controller_id: Int, scheduleName: String, valveIds: [Valve], startTime: String, daysOfweek: [Int], duration: Float, enabled: Bool) {
        self.controller_id = controller_id
        self.scheduleName = scheduleName
        self.valves = valveIds
        self.startTime = startTime
        self.daysOfweek = daysOfweek
        self.duration = duration
        self.enabled = enabled
    }
    
    init(from decoder: Decoder) throws {
        do {
            let schedule = try decoder.container(keyedBy: CodingKeys.self)
            self.controller_id = try schedule.decodeIfPresent(Int.self, forKey: .controller_id)!
            self.scheduleId = try schedule.decodeIfPresent(Int.self, forKey: .scheduleId)!
//            self.scheduleName = try schedule.decodeIfPresent(String.self, forKey: .scheduleName)
            self.valves = [] //try schedule.decodeIfPresent(Int.self, forKey: .controller_id)!
            self.startTime = try schedule.decodeIfPresent(String.self, forKey: .startTime)!
            self.duration = try schedule.decodeIfPresent(Float.self, forKey: .duration)!
            self.daysOfweek = []
            self.enabled = try schedule.decodeIfPresent(Bool.self, forKey: .enabled)!
            self.sunday = try schedule.decodeIfPresent(Bool.self, forKey: .sunday)!
            if sunday {
                self.daysOfweek.append(0)
            }
            self.monday = try schedule.decodeIfPresent(Bool.self, forKey: .monday)!
            if monday {
                self.daysOfweek.append(1)
            }
            self.tuesday = try schedule.decodeIfPresent(Bool.self, forKey: .tuesday)!
            if tuesday {
                self.daysOfweek.append(2)
            }
            self.wednesday = try schedule.decodeIfPresent(Bool.self, forKey: .wednesday)!
            if wednesday {
                self.daysOfweek.append(3)
            }
            self.thursday = try schedule.decodeIfPresent(Bool.self, forKey: .thursday)!
            if thursday {
                self.daysOfweek.append(4)
            }
            self.friday = try schedule.decodeIfPresent(Bool.self, forKey: .friday)!
            if friday {
                self.daysOfweek.append(5)
            }
            self.saturday = try schedule.decodeIfPresent(Bool.self, forKey: .saturday)!
            if saturday {
                self.daysOfweek.append(6)
            }
        } catch {
            print(error)
        }
    }
    
    func encodedJsonBody() -> Data {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            return jsonData
        } catch {
            print(error)
        }
        return Data()
    }
    
    enum CodingKeys: String, CodingKey {
        case controller_id
//        case scheduleName
//        case valveIds
        case startTime = "start_time"
        case duration
        case scheduleId = "id"
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
        case enabled
    }
}

