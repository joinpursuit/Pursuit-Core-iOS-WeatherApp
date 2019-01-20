//
//  Weather.swift
//  WeatherApp
//
//  Created by Leandro Wauters on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let response: [ResponseWrapper]
    struct ResponseWrapper: Codable{
        let periods: [PeriodsWrapper]
    }
}

struct PeriodsWrapper: Codable {
    let dateTimeISO: String
    let maxTempF: Int
    let minTempF: Int
    let windSpeedMPH: Int
    let weather: String
    let icon: String
    let sunriseISO: String
    let sunsetISO: String
    let precipIN: Double
}
