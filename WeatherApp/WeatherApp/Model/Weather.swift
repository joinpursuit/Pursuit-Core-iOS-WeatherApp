//
//  Weather.swift
//  WeatherApp
//
//  Created by Pritesh Nadiadhara on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct OuterLayer : Codable {
    let response : [WeatherData]
}

struct WeatherData : Codable {
    let periods : [WeatherDetailData]?
}

struct WeatherDetailData : Codable {
    let maxTempF : Int
    let minTempF : Int
    let icon : String
    let sunriseISO : String
    let sunsetISO : String
    let windSpeedMPH : Int
    let dateTimeISO : String
    let weather : String
    //let precipIN : Int
}
