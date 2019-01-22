//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Jeffrey Almonte on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct WeatherInfo: Codable {
    let response: [Response]
    struct Response: Codable {
        let periods: [Periods]
    }
}
struct Periods: Codable {
    let dateTimeISO: String
    let maxTempF: Int
    let maxTempC: Int
    let minTempF: Int
    let minTempC: Int
    let humidity: Int
    let windSpeedMPH: Int
    let windSpeedKPH: Int
    let weather: String
    let icon: String
    let sunriseISO: String
    let sunsetISO: String
    let precipIN: Double
    let precipMM: Double
}
//public var  date: Date {
//    let isoFomatter = ISO8601DateFormatter()
//    var fomattedDate = Date()
//    if let isoformatter.date(from: dateTime) {
//        fomattedDate = date
//    }
//    return fomattedDate
//}
