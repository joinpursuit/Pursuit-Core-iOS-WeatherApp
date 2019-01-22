//
//  WeatherForecasts.swift
//  WeatherApp
//
//  Created by Joshua Viera on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

//Aeris API
struct WeatherForcasts: Codable{
    var response: [Periods]
}

struct Periods: Codable{
    var periods: [WeatherInfo]
}

struct WeatherInfo: Codable{
    let dateTimeISO: String
    let maxTempF: Int?
    let minTempF: Int?
    let percipIN: Int?
    let weather: String
    let windSpeedMaxMPH: Int
    let sunriseISO: String
    let sunsetISO: String
    let icon: String
}
