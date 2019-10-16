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
    let sunriseTime: Int
    let sunsetTime: Int
    let windSpeed: Double
    let precipIntensityMax: Double
    
    func convertTimeToDate(time: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(time))
        let dateComponents = date.description.components(separatedBy: " ")
        return dateComponents[0]
    }
    func convertSunTime(time: Int) -> String  {
        let date = Date(timeIntervalSince1970: Double(time))
        //print(date)
        let dateComponents = date.description.components(separatedBy: " ")
        //print(dateComponents)
        let oldDateTime = DateFormatter()
        oldDateTime.dateFormat = "HH:mm:ss"
        let newDateTime = DateFormatter()
        newDateTime.dateFormat = "h:mm a"
        if let newTime = oldDateTime.date(from: dateComponents[1]) {
            return newDateTime.string(from: newTime)
        }
        return ""
    }
}
