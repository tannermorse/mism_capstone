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
    
    
    func getReceiversByController(controllerId: Int, completion: (([Int]) -> Void)? = nil) {
        var receivers = [Receiver]()
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "https://0z02zemtz2.execute-api.us-east-2.amazonaws.com/Development/controllers/\(controllerId)/receivers/")!,timeoutInterval: 10)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let status = response as? HTTPURLResponse {
                print("receivers: \(status.statusCode)")
            }
            if error != nil {
                print(error!)
            } else {
                
                do {
                    receivers = try JSONDecoder().decode([Receiver].self, from: data!)
                    var ids = [Int]()
                    for id in receivers {
                        ids.append(id.id!)
                    }
                    completion?(ids)
                } catch {
                    print("could not serialize receivers by  controller data")
                }
            }
        })
        task.resume()
    }
    
    func getValvesByController(controllerId: Int, receiverId: Int, completion: (([Valve]) -> Void)? = nil) {
        var valves = [Valve]()
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "https://0z02zemtz2.execute-api.us-east-2.amazonaws.com/Development/controllers/\(controllerId)/receivers/\(receiverId)/valves")!,timeoutInterval: 10)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let status = response as? HTTPURLResponse {
                print("valves by controller: \(status.statusCode)")
            }
            if error != nil {
                print(error!)
            } else {
                print(" all valves: \(data!.prettyPrintedJSONString)")
                do {
                    valves = try JSONDecoder().decode([Valve].self, from: data!)
                    completion?(valves)
                } catch {
                    print("could not serialize valves by controller")
                }
            }
        })
        task.resume()
    }
    
    func getValvesBySchedule(controllerId: Int, scheduleId: Int, completion: (([Valve]) -> Void)? = nil) {
        var valves = [Valve]()
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "https://0z02zemtz2.execute-api.us-east-2.amazonaws.com/Development/controllers/\(controllerId)/schedules/\(scheduleId)/valves")!,timeoutInterval: 10)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let status = response as? HTTPURLResponse {
                print("valves by schedule: \(status.statusCode)")
            }
            if error != nil {
                print(error!)
            } else {
                do {
                    valves = try JSONDecoder().decode([Valve].self, from: data!)
                    completion?(valves)
                } catch {
                    print("could not serialize valve by schedule data")
                }
            }
        })
        task.resume()
    }

}
