//
//  ImageData.swift
//  mism_capstone
//
//  Created by Tanner Morse on 3/25/20.
//  Copyright © 2020 Tanner Morse. All rights reserved.
//

import Foundation

struct ImageData: Codable {
    var image: String = ""
    var imagepath: String = ""
    
    init(image: String, imagePath: String) {
        self.image = image
        self.imagepath = imagePath
    }
    
    init(from decoder: Decoder) throws {
        do {
            let imageData = try decoder.container(keyedBy: CodingKeys.self)
            if let imageDataString = try imageData.decodeIfPresent(String.self, forKey: .image) {
                self.image = imageDataString
            }
            if let path = try imageData.decodeIfPresent(String.self, forKey: .imagepath) {
                self.imagepath = path
            }
        } catch {
            print(error)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case image
        case imagepath
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
}
