//
//  Images.swift
//  WeatherApp
//
//  Created by Joshua Viera on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Images: Codable {
    let totalHits: Int
    struct HitWrapper : Codable {
        let largeImageURL: URL
    }
    let hits: [HitWrapper]
}
