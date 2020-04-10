//
//  Valve.swift
//  mism_capstone
//
//  Created by Tanner Morse on 1/15/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import Foundation

struct Valve: Codable {
    var id: Int?
    var receiverId: Int?
    var status: Bool?
    var valveName: String?
    var imageUrl: String?
    var updatedAt: String?
    var createdAt: String?

    init(id: Int, receiverId: Int, status: Bool, valveName: String, imageUrl: String?, updatedAt: String?, createdAt: String?) {
        self.id = id
        self.receiverId = receiverId
        self.status = status
        self.valveName = valveName
        self.imageUrl = imageUrl
        self.updatedAt = updatedAt
        self.createdAt = createdAt
    }
    
    init(from decoder: Decoder) throws {
        do {
            let valve = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try valve.decodeIfPresent(Int.self, forKey: .id) ?? nil
            self.receiverId = try valve.decodeIfPresent(Int.self, forKey: .receiverId) ?? 1
            self.status = try valve.decodeIfPresent(Bool.self, forKey: .status) ?? false
            self.valveName = try valve.decodeIfPresent(String.self, forKey: .valveName) ?? ""
            self.imageUrl = try valve.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
            self.createdAt = try valve.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
            self.updatedAt = try valve.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""

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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(receiverId, forKey: .receiverId)
        try container.encode(status, forKey: .status)
        try container.encode(valveName, forKey: .valveName)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "valve_id"
        case receiverId = "receiver_id"
        case status
        case valveName = "valve_name"
        case imageUrl = "image_url"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}


