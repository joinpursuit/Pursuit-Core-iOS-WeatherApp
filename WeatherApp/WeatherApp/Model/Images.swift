//
//  Images.swift
//  WeatherApp
//
//  Created by Biron Su on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Hits: Codable {
    let totalHits: Int
    let hits: [Images]
}

struct Images: Codable {
    let largeImageURL: URL
}
