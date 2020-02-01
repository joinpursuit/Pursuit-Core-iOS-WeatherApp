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
    static func fetchWeather(for zipCode: String, completion: @escaping (Result<Weather, AppError>) ->()) {
        
        let zipCode = zipCode.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "11221"
        
        let weatherEndpointUrl = "https://api.darksky.net/forecast/\(SecretKey.apikey)/\(zipCode)"
        
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
