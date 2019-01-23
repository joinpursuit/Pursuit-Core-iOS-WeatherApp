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
    let validTime: String
    let maxTempF: Int
    let minTempF: Int
    let weather: String
    let precipMM: Double
    let icon: String
    var images: String {
        let imageArray = icon.components(separatedBy: ".")
        return imageArray[0]
    }
    let sunrise: Int
    let sunriseISO: String
    let sunset: Int
    let sunsetISO: String
    let windSpeedMaxMPH: Int
    var dateFormattedString: String{
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = validTime
        if let date = isoDateFormatter.date(from: validTime){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-dd-MM"
            
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
    
    
    
    var sunriseTime: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedSunriseISO = sunriseISO
        if let date = isoDateFormatter.date(from: sunriseISO){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:ss"
            
            formattedSunriseISO = dateFormatter.string(from: date)
            
        }
        return formattedSunriseISO
    }
    
    var sunsetTime: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedSunsetISO = sunsetISO
        if let date = isoDateFormatter.date(from: sunsetISO){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:ss"
            
            formattedSunsetISO = dateFormatter.string(from: date)
            
        }
        return formattedSunsetISO

    }

}
