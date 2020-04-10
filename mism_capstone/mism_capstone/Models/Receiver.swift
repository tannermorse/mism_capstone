//
//  Receiver.swift
//  mism_capstone
//
//  Created by Tanner Morse on 4/9/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import Foundation

struct Receiver: Codable {
    
    var id: Int!
    init(from decoder: Decoder) throws {
        do {
            let receiver = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try receiver.decodeIfPresent(Int.self, forKey: .id)!
        } catch {
            print(error)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}
