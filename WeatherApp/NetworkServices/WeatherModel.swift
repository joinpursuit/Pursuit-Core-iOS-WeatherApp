//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct Weather: Codable & Equatable {
    
    
    
    
    let latitude: Double
    let longitude: Double
    let timezone: String
    let currently: Currently
    let daily: Daily
    
}

struct Daily: Codable & Equatable{
    let summary: String
        let icon: String?
        let data: [DailyDatum]
    }

    struct DailyDatum: Codable & Equatable{
        let time: Int
       // let summary: String
        let icon: String
        let sunriseTime: Int
        let sunsetTime: Int
        let precipType: String?
        let temperatureHigh: Double
        let temperatureLow: Double
        let windSpeed: Double
        let windGust: Double
    }



struct Currently: Codable & Equatable {
    
    let summary: String?
    let icon: String
    let temperature: Double
    let windSpeed: Double
    let precipType: String?
}


