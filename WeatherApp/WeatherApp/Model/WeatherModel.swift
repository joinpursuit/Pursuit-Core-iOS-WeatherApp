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
    public var dateFormattedTime: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = validTime
        if let date = isoDateFormatter.date(from: validTime){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
    let maxTempF: Int
    let minTempF: Int
    let avgTempF: Int
    let sunrise: Double
    let sunriseISO: String
    public var dateFormattedSunrise: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = sunriseISO
        if let date = isoDateFormatter.date(from: sunriseISO){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
  
    
    let sunset: Double
    let sunsetISO: String
    public var dateFormattedSunset: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = sunsetISO
        if let date = isoDateFormatter.date(from: sunsetISO){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
    let windSpeedMPH: Int
    let precipIN: Double
    let icon: String
}

struct locationName: Codable {
    let tz: String
}
