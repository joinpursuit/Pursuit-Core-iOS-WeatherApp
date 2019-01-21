//
//  WeatherAppModel.swift
//  WeatherApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct WeatherInformation: Codable {
    var response:[WeatherFocasts]
}
struct WeatherFocasts: Codable {
    let periods:[PeriodsInformation]
}
struct PeriodsInformation: Codable {
    let timestamp: Int
    let validTime: String
    let dateTimeISO: String
    let maxTempF: Int
    let minTempF: Int
    let humidity: Int
    let weather: String
    let weatherPrimary: String
    let icon: String
    let sunrise: Int
    let sunriseISO: String
    let sunset: Int
    let sunsetISO: String
    let windSpeedMaxMPH: Int
}

