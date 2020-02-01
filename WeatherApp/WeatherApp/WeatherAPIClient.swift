//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct WeatherAPIClient {
    static func fetchWeather(with coordinate: (Double, Double), // with coordinates or separatelly lat and long?
                             completion: @escaping (Result<Weather, AppError>) -> ()) {
    let endpointURLString =
        "https://api.darksky.net/forecast/\(SecretKey.apikey)/\(coordinate)"
    guard let url = URL(string: endpointURLString) else {
      completion(.failure(.badURL(endpointURLString)))
      return
    }
    let request = URLRequest(url: url)
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        do {
            let weatherSearch = try JSONDecoder().decode(Weather.self, from: data)
          completion(.success(weatherSearch))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
}
