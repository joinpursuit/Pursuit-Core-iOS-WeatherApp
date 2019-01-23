//
//  Weather.swift
//  WeatherApp
//
//  Created by Stephanie Ramirez on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct DayInfo: Codable {
    let response: [Response]
}
struct Response: Codable {
//    let loc: [Location]
    let periods: [Temperature]
}
//struct Location: Codable {
//    let long: Double
//    let lat: Double
//}
struct Temperature: Codable {
//    let timestamp: 1548072000
    let validTime: String
    let dateTimeISO: String
    let maxTempF: Int
    let minTempF: Int
    let avgTempF: Int
//    let tempC": null,
//    let tempF": null,
    let precipIN: Double
//    let iceaccumIN: Int
    let maxHumidity: Int
    let minHumidity: Int
    let humidity: Int
    let uvi: Int
    let pressureMB: Int
    let pressureIN: Double
    let sky: Int
//    let snowCM: Int
//    let snowIN: Int
//    let feelslikeC": -24,
//    let feelslikeF": -12,
//    let minFeelslikeC": -25,
//    let minFeelslikeF": -14,
//    let maxFeelslikeC": -21,
//    let maxFeelslikeF": -6,
//    let avgFeelslikeC": -23,
//    let avgFeelslikeF": -9,
//    let dewpointC": -22,
//    let dewpointF": -7,
//    let maxDewpointC": -21,
//    let maxDewpointF": -6,
//    let minDewpointC": -23,
//    let minDewpointF": -10,
//    let avgDewpointC": -22,
//    let avgDewpointF": -8,
//    let windDirDEG": 300,
//    let windDir": "WNW",
//    let windDirMaxDEG": 310,
//    let windDirMax": "NW"
//    let windDirMinDEG": 300,
//    let windDirMin": "WNW",
//    let windGustKTS": 38,
//    let windGustKPH": 70,
    let windGustMPH: Int
//    let windSpeedKTS": 24,
//    let windSpeedKPH": 44,
    let windSpeedMPH: Int
//    let windSpeedMaxKTS": 28,
//    let windSpeedMaxKPH": 52,
//    let windSpeedMaxMPH": 32,
//    let windSpeedMinKTS": 12,
//    let windSpeedMinKPH": 22,
//    let windSpeedMinMPH": 14,
//    let windDir80mDEG": 302,
//    let windDir80m": "WNW",
//    let windDirMax80mDEG": 310,
//    let windDirMax80m": "NW",
//    let windDirMin80mDEG": 300,
//    let windDirMin80m": "WNW",
//    let windGust80mKTS": 30,
//    let windGust80mKPH": 55,
//    let windGust80mMPH": 34,
//    let windSpeed80mKTS": 27,
//    let windSpeed80mKPH": 50,
//    let windSpeed80mMPH": 31,
//    let windSpeedMax80mKTS": 30,
//    let windSpeedMax80mKPH": 55,
//    let windSpeedMax80mMPH": 34,
//    let windSpeedMin80mKTS": 23,
//    let windSpeedMin80mKPH": 43,
//    let windSpeedMin80mMPH": 27,
    let weather: String
//    let weatherCoded: [WeatherCoded]
    let weatherPrimary: String
//    let weatherPrimaryCoded": "IS:VL:SW",
//    let cloudsCoded": "SC",
    let icon: String
    var iconImage: String {
        var array = [String]()
        array.append(contentsOf: icon.components(separatedBy: "."))
        return array[0]
    }
    let isDay: Bool
//    let sunrise: 1548072846,
    let sunriseISO: String
//    let sunset: 1548107973,
    let sunsetISO: String
}

