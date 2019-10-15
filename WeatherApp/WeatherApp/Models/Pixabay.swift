//
//  Pixabay.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct PhotoWrapper: Codable {
    let hits: [Photo]
}

struct Photo: Codable {
    let webformatURL: String
}
