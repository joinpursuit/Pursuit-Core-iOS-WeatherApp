//
//  Weather.swift
//  WeatherApp
//
//  Created by Biron Su on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var response: [Periods]
    let success: Bool
}

struct Periods: Codable {
    var periods: [WeatherInfo]
}

struct WeatherInfo: Codable {
    let dateTimeISO: String
    let maxTempF: Int
    let minTempF: Int
    let precipIN: Double
    let weather: String
    let icon: String
    let windSpeedMaxMPH: Int
    let sunriseISO: String
    let sunsetISO: String
}
