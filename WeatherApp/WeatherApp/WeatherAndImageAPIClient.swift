//
//  WeatherAndImageAPIClient.swift
//  WeatherAppTests
//
//  Created by Leandro Wauters on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


final class WeatherAndImageAPIClient {
    static func searchCityWeather(zipCode: String, completionHandler: @escaping (AppError?, [PeriodsWrapper]?) -> Void) {
    
    let endpointURLString = "https://api.aerisapi.com/forecasts/\(zipCode)?client_id=\(SecretKeys.weatherID)&client_secret=\(SecretKeys.weatherSecretKey)"
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
//                    events = events.sorted { $0.dates.start.dateTime.dateFromISODateString() < $1.dates.start.dateTime.dateFromISODateString() }
                    completionHandler(nil, weatherData.response[0].periods)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        }.resume()
    }
    
    static func getCityImages(city: String, completionHandler: @escaping (AppError?, [Image.HitWrapper]?) -> Void) {
        let city = city.replacingOccurrences(of: " ", with: "+")
        
        let endpointURLString = "https://pixabay.com/api/?key=\(SecretKeys.imageSecretKey)&q=\(city)&image_type=photo"
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
                    let imageData = try JSONDecoder().decode(Image.self, from: data)
                    //                    events = events.sorted { $0.dates.start.dateTime.dateFromISODateString() < $1.dates.start.dateTime.dateFromISODateString() }
                    completionHandler(nil, imageData.hits)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
            }.resume()
    }
}
