//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Genesis Mosquera on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct Weather: Codable {
    let responseWrapper: [Response]
}
struct Response: Codable {
    let loc: String
    let periodsWrapper: [Periods]
}
struct Periods: Codable {
    let timestamp: Int
    let validTime: String
    let datetimeISO: String
    let maxTempF: Int
    let minTempF: Int
    let avgTempF: Int
    let sunrise: Int
    let sunriseISO: String
    let sunset: Int
    let sunsetISO: String
    let windSpeedMPH: Int
    let precipIN: Int 
}
