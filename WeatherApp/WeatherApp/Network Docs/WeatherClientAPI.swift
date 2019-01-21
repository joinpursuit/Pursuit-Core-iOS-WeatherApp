//
//  WeatherClientAPI.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class WeatherAPIClient {

  static func searchWeather(keyword: String, completionHandler: @escaping (AppError?, [WeatherDetails]?) -> Void){
   
  var urlString =  "http://api.aerisapi.com/forecasts/\(keyword)?client_id=\(Constants.weatherClientID)&client_secret=\(Constants.weatherSecretKey)"
    
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
          let weatherData = try JSONDecoder().decode(WeatherInfo.self, from: data)
          completionHandler(nil, weatherData.periods)
        } catch {
          completionHandler(AppError.decodingError(error), nil)
        }
      }
    }
  }
  
}
