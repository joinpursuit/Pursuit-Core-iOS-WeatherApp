//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Pursuit on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct weather:Codable {
    let response: [daysOfTheWeek]?
}
struct daysOfTheWeek: Codable{
    let periods: [eachDay]?
}
struct eachDay:Codable {
    let dateTimeISO: String?
    let maxTempF: Int?
    let minTempF: Int?
    let precipIN: Double
    let maxFeelslikeF: Int
    let windSpeedMaxMPH: Int
    let weather: String
}
