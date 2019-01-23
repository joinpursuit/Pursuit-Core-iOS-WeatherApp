//
//  Weather.swift
//  WeatherApp
//
//  Created by Stephanie Ramirez on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct DayInfo: Codable {
    let response: [Response]
}
struct Response: Codable {
    let periods: [Temperature]
}

struct Temperature: Codable {
    let validTime: String
    let dateTimeISO: String
    let maxTempC: Int
    let maxTempF: Int
    let minTempC: Int
    let minTempF: Int
    let avgTempF: Int

    let precipIN: Double
    let maxHumidity: Int
    let minHumidity: Int
    let humidity: Int
    let uvi: Int
    let pressureMB: Int
    let pressureIN: Double
    let sky: Int
    let windGustMPH: Int
    let windSpeedMPH: Int
    let weather: String
    let weatherPrimary: String
    let icon: String
    var iconImage: String {
        var array = [String]()
        array.append(contentsOf: icon.components(separatedBy: "."))
        return array[0]
    }
    let isDay: Bool
    let sunriseISO: String
    let sunsetISO: String
}

