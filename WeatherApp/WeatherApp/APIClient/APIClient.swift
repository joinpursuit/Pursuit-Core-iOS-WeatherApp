//
//  APIClient.swift
//  WeatherApp
//
//  Created by Joshua Viera on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class APIClient {

    static func getForecasts(keyword: String , completionHandler: @escaping (Error?, [WeatherInfo]? ) -> Void){
        let urlString = "http://api.aerisapi.com/forecasts/\(keyword)?client_id=\(SecretKeys.accesID)&client_secret=\(SecretKeys.APIKey)"
        NetworkHelper.shared.performDataTask(endpointURLString: urlString) { (error, data, httpResponse) in
            if let error = error{
                print(error)
                completionHandler(AppError.badStatusCode(urlString), nil)
            }
            if let data = data {
                do {
                    let forecast = try JSONDecoder().decode(WeatherForcasts.self, from: data)
                    completionHandler(nil, forecast.response[0].periods)
                    print(data)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
            if let response = httpResponse{
                if response.statusCode == 200{
                    print("GOOD: \(response.statusCode)")
                } else {
                    print("BAD: \(response.statusCode)")
                }
            }
        }
    }
}
