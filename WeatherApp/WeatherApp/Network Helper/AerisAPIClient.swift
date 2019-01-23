//
//  AerisAPIClient.swift
//  WeatherApp
//
//  Created by Jane Zhu on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class AerisAPIClient {
    private init() {}
    static func searchLocation(zipcodeOrCity: String, isZipcode: Bool, completionHandler: @escaping (AppError?, [DailyForecast]?) -> Void) {
        var endpointURLString = ""
        if isZipcode {
            endpointURLString = "http://api.aerisapi.com/forecasts/\(zipcodeOrCity)?client_id=\(SecretKeys.aerisAPIid)&client_secret=\(SecretKeys.aerisAPISecret)"
        }
        else {
            endpointURLString = "https://api.aerisapi.com/forecasts/\(zipcodeOrCity)?&format=json&filter=day&limit=7&client_id=\(SecretKeys.aerisAPIid)&client_secret=\(SecretKeys.aerisAPISecret)"
        }
        
        guard let url = URL(string: endpointURLString) else {
            completionHandler(AppError.badURL(endpointURLString), nil)
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil)
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode("\(statusCode)"), nil)
                    return
            }
            if let data = data {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    if let responseExists = weatherData.response {
                        if let periodExists = responseExists.first?.periods {
                            completionHandler(nil, periodExists)
                        }
                    }
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
            }.resume()
    }
}
