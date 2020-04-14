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
    
    
    func switchValveState(controllerId: String, receiverId: String, valveId: String, valveStatus: Bool) {
        // send to api to switch the state of the valve
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            var component = URLComponents(string: "https://0z02zemtz2.execute-api.us-east-2.amazonaws.com/Development/controllers/\(controllerId)/receivers/\(receiverId)/valves/\(valveId)/flip")
            component?.queryItems = [URLQueryItem(name: "valve_status", value: String(valveStatus))]
            
            if let url = component?.url {
                print(url)
                let session = URLSession.shared
                var request = URLRequest(url: url, timeoutInterval: 10)
                request.httpMethod = "POST"
                request.addValue(token, forHTTPHeaderField: "Authorizer")
                let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    if let status = response as? HTTPURLResponse {
                        print("change valve state: \(status.statusCode)")
                    }
                    if error != nil {
                        print(error!)
                    }
                })
                task.resume()
            }
//            let session = URLSession.shared
//            var request = URLRequest(url: URL(string: "https://0z02zemtz2.execute-api.us-east-2.amazonaws.com/Development/controllers/\(controllerId)/receivers/\(receiverId)/valves/\(valveId)/flip?valve_status=\(valveStatus)")!,timeoutInterval: 10)
//            request.httpMethod = "POST"
//            request.addValue(token, forHTTPHeaderField: "Authorizer")
//
//            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//                if let status = response as? HTTPURLResponse {
//                    print("change valve state: \(status.statusCode)")
//                }
//                if error != nil {
//                    print(error!)
//                }
//            })
//            task.resume()
        }
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
    
    func addValvesToSchedule(controllerId: Int, scheduleId: Int, valves: [Valve], completion: ((Bool) -> Void)? = nil) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "https://0z02zemtz2.execute-api.us-east-2.amazonaws.com/Development/controllers/\(controllerId)/schedules/\(scheduleId)/valves")!,timeoutInterval: 10)
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        do {
            let ids = valves.map { $0.id! }
            request.httpBody = try encoder.encode(ids)
        } catch {
            print("can't encode valves")
            print(error)
            return
        }
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let status = response as? HTTPURLResponse {
                print("add valves to schedule: \(status.statusCode)")
            }
            if error != nil {
                print(error!)
            }
        })
        task.resume()
    }

}
