//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Pursuit on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class WeatherApiClient{
    static func WeatherSearch(zipCode:String, completionHandler: @escaping (AppError?,[daysOfTheWeek]?) -> Void) {
let WeatherUrl = "https://api.aerisapi.com/forecasts/\(zipCode)?&format=json&filter=day&limit=7&fields=periods.dateTimeISO,loc,periods.maxTempF,periods.minTempF,periods.precipIN,periods.maxFeelslikeF,periods.windSpeedMaxMPH,periods.weather&client_id=\(SecretKey.ClientsID)&client_secret=\(SecretKey.APIkey)"
NetworkHelper.shared.performDataTask(endpointURLString:WeatherUrl, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError,nil)
                 print("Here0")
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode(String(statusCode)), nil)
                    return
            }
            if let data = data {
                do {
                    let WeatherData = try JSONDecoder().decode(weather.self, from: data)
                    completionHandler(nil,WeatherData.response)
                     print("Here2")
                } catch {
                    print("Here1")
                    completionHandler(AppError.decodingError(error),nil)
                }
            }
        }
}
}
