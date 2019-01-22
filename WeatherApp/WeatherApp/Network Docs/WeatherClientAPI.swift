//
//  WeatherClientAPI.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class WeatherAPIClient {

  static func searchWeather(zipCode: String, completionHandler: @escaping (AppError?, [WeatherInfo]?) -> Void){
   
    let urlString = "https://api.aerisapi.com/forecasts/\(zipCode)?&format=json&filter=day&limit=7&client_id=\(Constants.weatherClientID)&client_secret=\(Constants.weatherSecretKey)"
    
  
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
          let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
          completionHandler(nil, weatherData.response)
        } catch {
          completionHandler(AppError.decodingError(error), nil)
        }
      }
    }
  }
  
}


