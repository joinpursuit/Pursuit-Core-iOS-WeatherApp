//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
  let response: [WeatherInfo]
}

struct WeatherInfo: Codable {
  let periods: [WeatherDetails]?
  let profile: CityName?

}

struct WeatherDetails: Codable {
  //  let timestamp: //timestamp
  let validTime: String
  let dateTimeISO: String
  let maxTempC: Int
  let maxTempF: Int
  let minTempC: Int
  let minTempF: Int
  let precipIN: Double
  let windSpeedKPH: Int
  let windSpeedMPH: Int
  let weather: String
  //  let sunrise: //1547900135
  let sunriseISO: String
  //  let sunset: //1547935089
  let sunsetISO: String
  let icon: String //pcloudy.png
  
  
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
  
  public var sunsetFormattedString: String {
    let isoDateFormatter = ISO8601DateFormatter()
    var formattedDate = sunriseISO
    if let date = isoDateFormatter.date(from: sunriseISO) {
     let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"
      formattedDate = dateFormatter.string(from: date)
    }
    return formattedDate
  }
  
}

struct CityName: Codable {
  let tz: String
  
  public var cityName: String {
    var arrayOfCityText = [String]()
    var stringToReturn = String()
    arrayOfCityText.append(contentsOf: tz.components(separatedBy: "/"))
    if let city = arrayOfCityText.last{
      stringToReturn = city
    } else {
      stringToReturn = "City name wasn't identified"
    }
    return stringToReturn
  }
  
}

