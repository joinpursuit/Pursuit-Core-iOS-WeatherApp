//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Genesis Mosquera on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class WeatherAPIClient {
    private init() {}
    static func searchWeather(keyword: String, isZipcode: Bool, completionHandler: @escaping (AppError?, [Periods]?) -> Void) {
        var endpointURLString = ""
        if isZipcode {
            endpointURLString = "https://api.aerisapi.com/forecasts/10014?&format=json&filter=day&limit=7&client_id=CLIENT_ID&client_secret=CLIENT_SECRET"
        } else {
            endpointURLString = "https://api.aerisapi.com/forecasts/10014?&format=json&filter=day&limit=7&client_id=CLIENT_ID&client_secret=CLIENT_SECRET"
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
                    let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        }.resume()
    }
    
}
