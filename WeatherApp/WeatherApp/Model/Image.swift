//
//  Image.swift
//  WeatherApp
//
//  Created by Leandro Wauters on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Image: Codable {
    let totalHits: Int
    struct HitWrapper: Codable {
        let largeImageURL: URL
    }
    let hits: [HitWrapper]
}
