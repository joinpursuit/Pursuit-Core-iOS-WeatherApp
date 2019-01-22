//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Jose Alarcon Chacon on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
final class WeatheAPIClient {
    private init() {}
    static func searchWeatherEvent(isZipcode: Bool, completionHandler: @escaping((AppError?, WeatherResponse?) -> Void)) {
        var endpointURLString = ""
        if isZipcode {
            endpointURLString = "https://api.aerisapi.com/forecasts/\(startingZip)?client_id=Xx43EQbfEbNqbMLT9H3zX&client_secret=\(SecretKeys.APIKey)"}
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
                    let data = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    completionHandler(nil,data)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error),nil)
                }
            }
        }.resume()
    }
    static func getCity(completionHandler: @escaping((AppError?, ImageHits?) -> Void)) {
       let endpointURLString = "https://pixabay.com/api/?key=\(SecretKeys.CityAPIKey)&q=miami&image_type=photo"
        guard let url = URL(string: endpointURLString) else {
            completionHandler(AppError.badURL(endpointURLString),nil)
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
                    let data = try JSONDecoder().decode(ImageHits.self, from: data)
                    completionHandler(nil,data)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error),nil)
                }
            }
        }.resume()
    }
}
