//
//  SwellModel.swift
//  SurflineJonathanKopp
//
//  Created by Jonathan Kopp on 9/17/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation

struct SwellElement: Decodable {
    let shapeFull: String
    let size: Int
    let spotID: Int
    let spotName: String
    let shapeDetail: ShapeDetial
    
    enum CodingKeys: String, CodingKey {
        case shapeFull = "shape_full"
        case size
        case spotID = "spot_id"
        case spotName = "spot_name"
        case shapeDetail = "shape_detail"
    }
}

struct ShapeDetial: Codable {
    let tide: String
    let wind: String
}

typealias Swell = [SwellElement]

//struct swells: Codable{
//    let SwellElements: [SwellElement]
//}
