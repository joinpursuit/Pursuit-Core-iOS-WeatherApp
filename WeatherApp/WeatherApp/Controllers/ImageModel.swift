//
//  ImageModel.swift
//  WeatherApp
//
//  Created by Manny Yusuf on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct weatherImages: Codable {
    let hits: [ImageData]
}

struct ImageData: Codable {
    let largeImageURL: String
}
