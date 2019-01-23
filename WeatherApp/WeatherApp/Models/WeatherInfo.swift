//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Jeffrey Almonte on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct WeatherInfo: Codable {
    let response: [Forecasts]
}
struct Forecasts: Codable {
    let periods: [Periods]
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
    
    public var dateFormattedString: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = dateTimeISO
        if let date = isoDateFormatter.date(from: dateTimeISO) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
}
