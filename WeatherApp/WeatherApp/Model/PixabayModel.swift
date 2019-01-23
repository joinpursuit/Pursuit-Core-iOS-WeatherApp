//
//  PixabayModel.swift
//  WeatherApp
//
//  Created by Genesis Mosquera on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Pictures: Codable {
    let hits: [ImageInfo]
}
struct ImageInfo: Codable {
    let largeImageURL: String
}
