//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct WeatherAPIClient {
    // do lat and long instead of zip
    static func fetchWeather(for lat: Double, long: Double, completion: @escaping (Result<Weather, AppError>) ->()) {
        
        let weatherEndpointUrl = "https://api.darksky.net/forecast/\(SecretKey.apikey)/\(lat),\(long)"
        
        guard let url = URL(string: weatherEndpointUrl) else {
            completion(.failure(.badURL(weatherEndpointUrl)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion( .failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: data)
                    completion(.success(weather))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
