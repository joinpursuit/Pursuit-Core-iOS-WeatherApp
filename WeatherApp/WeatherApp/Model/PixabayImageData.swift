//
//  PixabayImageData.swift
//  WeatherApp
//
//  Created by Jane Zhu on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct PixabayImageData: Codable {
    let hits: [PixabayImages]
}

struct PixabayImages: Codable {
    let largeImageURL: String
}
