//
//  Pixabay.swift
//  WeatherApp
//
//  Created by Matthew Huie on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Pixabay: Codable {
    let hits: [LargeImage]
}

struct LargeImage: Codable {
    let largeImageURL: URL
}
