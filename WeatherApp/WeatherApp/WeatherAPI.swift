//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Jeffrey Almonte on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class WeatherAPIClient {
    
    static func searchWeather(keyword: String, completionHandler: @escaping (AppError?, [Periods]?) -> Void){
        
        let urlString = "https://api.aerisapi.com/forecasts/\(keyword)?&format=json&filter=day&limit=7&client_id=\(SecretKeys.weatherID)&client_secret=\(SecretKeys.weatherKey)"
        
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            
            if let appError = appError {
                completionHandler(appError, nil)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode(String(statusCode)), nil)
                    return
            }
            if let data = data {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherInfo.self, from: data).response.first?.periods
                    completionHandler(nil, weatherData)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        }
    }
    
}
