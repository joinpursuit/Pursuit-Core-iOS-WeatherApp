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
    let dateTimeISO: String
    let maxTempF: Int
    let minTempF: Int
    let precipIN: Double
    let weather: String
    let icon: String
    let windSpeed80mMPH: Int
    let sunriseISO: String
    let sunsetISO: String
}
