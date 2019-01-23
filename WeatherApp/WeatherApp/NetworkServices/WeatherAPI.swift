//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Pritesh Nadiadhara on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class WeatherAPIClient {
    static func searchWeatherByZipcode (zipcode: String, completionHandler: @escaping (AppError?,[WeatherDetailData]?) -> Void) {
        let urlString = "https://api.aerisapi.com/forecasts/\(zipcode)?&format=json&filter=day&limit=7&client_id=\(SecretKeys.client_ID)&client_secret=\(SecretKeys.client_Secret)"
        NetworkHelper.performDataTask(urlString: urlString, httpMethod: "GET") { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let weatherData = try JSONDecoder().decode(OuterLayer.self, from: data)
                    completionHandler(nil, weatherData.response.first?.periods)
                } catch {
                    completionHandler(AppError.decodingError(error),nil)
                }
            }
        }
    }
    
}
