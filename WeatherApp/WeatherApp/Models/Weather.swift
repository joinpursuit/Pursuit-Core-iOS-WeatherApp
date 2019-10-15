//
//  Weather.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
struct Weather: Codable {
    let daily: DailyWrapper
}

struct DailyWrapper: Codable {
    let data: [DataWrapper]
}

struct DataWrapper: Codable {
    let time: Int
    let summary: String
    let icon: String
    let temperatureHigh: Double
    let temperatureLow: Double
}
