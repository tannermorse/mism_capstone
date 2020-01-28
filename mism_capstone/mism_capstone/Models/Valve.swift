//
//  Valve.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/15/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import Foundation

struct Valve {
    var id: String
    var zoneName: String
    var imageUrl: String?
    var latitude: Double
    var longitude: Double
    var receiverId: String
    var schedules: [Schedule]
}


