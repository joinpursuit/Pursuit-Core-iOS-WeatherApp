//
//  ImageModel.swift
//  WeatherApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Image: Codable {
    let hits: [ImageDetails]
}
struct ImageDetails: Codable {
    let largeImage: String
}

