//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Jeffrey Almonte on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class WeatherAPIClient {
    
    static func searchWeather(keyword: String, completionHandler: @escaping (AppError?, [WeatherInfo]?) -> Void){
        
        let urlString = "https://api.aerisapi.com/forecasts/11101?&format=json&filter=day&limit=7&client_id=\(SecretKeys.weatherID)&client_secret=\(SecretKeys.weatherKey)"
        
        
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
                    let weatherData = try JSONDecoder().decode(WeatherInfo.self, from: data)
                    completionHandler(nil, [weatherData])
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        }
    }
    
}
