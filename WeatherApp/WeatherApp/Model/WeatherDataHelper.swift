//
//  WeatherDataHelper.swift
//  WeatherApp
//
//  Created by Jane Zhu on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct WeatherDataHelper {
    static func formatISOToDate(dateString: String) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = dateString
        if let date = isoDateFormatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E MM/dd"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
        
    }
    static func formatISOToTime(dateString: String) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = dateString
        if let date = isoDateFormatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
    static func formatMoreInfo(dailyForecast: DailyForecast, isMetric: Bool) -> String {
        if isMetric {
            return "High: \(dailyForecast.maxTempC)°C \nLow: \(dailyForecast.minTempC)°C \nSunrise: \(WeatherDataHelper.formatISOToTime(dateString: dailyForecast.sunriseISO)) \nSunset: \(WeatherDataHelper.formatISOToTime(dateString: dailyForecast.sunsetISO)) \nWindspeed: \(dailyForecast.windSpeedKPH) KPH \nPrecipitation: \(dailyForecast.precipMM) mm"

        } else {
            return "High: \(dailyForecast.maxTempF)°F \nLow: \(dailyForecast.minTempF)°F \nSunrise: \(WeatherDataHelper.formatISOToTime(dateString: dailyForecast.sunriseISO)) \nSunset: \(WeatherDataHelper.formatISOToTime(dateString: dailyForecast.sunsetISO)) \nWindspeed: \(dailyForecast.windSpeedMPH) MPH \nPrecipitation: \(dailyForecast.precipIN) in"
        }
    }
}
