//
//  Weather.swift
//  WeatherApp
//
//  Created by Matthew Huie on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let response: [Forcast]
}

struct Forcast: Codable {
    let periods: [ForcastData]
}

struct ForcastData: Codable {
    //let timestamp:
    let maxTempF: Int
    let minTempF: Int
    let precipIN: Int
    let weather: String
    let windSpeed80mMPH: Int
    //let sunrise:
    //let sunset:
}
