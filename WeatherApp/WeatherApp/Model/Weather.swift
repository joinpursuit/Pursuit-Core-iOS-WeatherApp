//
//  Weather.swift
//  WeatherApp
//
//  Created by Manny Yusuf on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct WeatherTrack: Codable {
    let response: [WeatherLocation]?
}

struct WeatherLocation: Codable {
//    let long: Double?
//    let lat: Double?
    let periods: [Weather]?
    let profile: locationName?
}

struct Weather: Codable {
    let validTime: String
    let dateTimeISO: String
    let maxTempF: Int
    let minTempF: Int
    let avgTempF: Int
    let precipMM: Double
    let windSpeedMPH: Int
    let weather: String
    let weatherPrimary: String
    let sunriseISO: String
    let sunsetISO: String
    let icon: String
    public var iconImage: String {
        var imageArray = [String]()
        imageArray.append(contentsOf: icon.components(separatedBy: "."))
        return imageArray[0]
    }
    let isDay: Bool

}
struct locationName: Codable {
    let tz:String
}
