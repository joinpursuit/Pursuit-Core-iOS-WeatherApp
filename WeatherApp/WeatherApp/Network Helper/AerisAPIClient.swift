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
    static func searchLocation(keyword: String, isZipcode: Bool, completionHandler: @escaping (AppError?, [DailyForecast]?) -> Void) {
        var endpointURLString = ""
        if isZipcode {
            endpointURLString = "http://api.aerisapi.com/forecasts/\(keyword)?client_id=\(SecretKeys.aerisAPIid)&client_secret=\(SecretKeys.aerisAPISecret)"
        }
//        else {
//            endpointURLString = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=\(SecretKeys.APIKey)&city=\(keyword)&radius=500&unit=miles"
//        }
        
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
                        if let periodExists = responseExists[0].periods {
                      //  daily = events.sorted { $0.dates.start.dateTime.dateFromISODateString() < $1.dates.start.dateTime.dateFromISODateString() }
                            completionHandler(nil, periodExists)
                        }
                    }
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
            }.resume()
    }
}
