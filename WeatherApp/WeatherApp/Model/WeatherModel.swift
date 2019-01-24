//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Genesis Mosquera on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let success: Bool 
    let response: [ResponseWrapper]
}

struct ResponseWrapper: Codable {
    let periods: [Periods]
    let profile: locationName?
    
}

struct Periods: Codable {
    let timestamp: Double
    let validTime: String
    let maxTempF: Int
    let minTempF: Int
    let avgTempF: Int
    let sunrise: Double
    let sunriseISO: String
    let sunset: Double
    let sunsetISO: String
    let windSpeedMPH: Int
    let precipIN: Double
    let icon: String
}

struct locationName: Codable {
    let tz: String
}
