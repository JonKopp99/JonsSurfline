//
//  SpotsModel.swift
//  SurflineJonathanKopp
//
//  Created by Jonathan Kopp on 9/17/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation

// MARK: - Spot
struct Spot: Codable {
    let latitude, longitude: Double
    let spotID: Int
    let spotName: String
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case spotID = "spot_id"
        case spotName = "spot_name"
    }
}

typealias Spots = [Spot]

