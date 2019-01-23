//
//  Weather.swift
//  WeatherApp
//
//  Created by Jose Alarcon Chacon on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct WeatherData: Codable {
    let timestamp: Int
    let validTime: String
    let maxTempF: Int
    let minTempF: Int
    let pressureIN: Double
    let windSpeedMPH: Int
    let sunrise: Int
    let sunriseISO: String
    let sunset: Int
    let sunsetISO: String
    let dateTimeISO: String
    let icon: String
    let weather: String
}
struct Location: Codable {
    var periods: [WeatherData]
}
struct WeatherResponse: Codable {
    var response: [Location]
}
