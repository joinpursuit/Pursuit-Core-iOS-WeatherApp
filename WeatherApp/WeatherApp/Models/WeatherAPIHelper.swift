//
//  WeatherAPIHelper.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
class WeatherAPIHelper {
    private init() {}
    static let manager = WeatherAPIHelper()
    func getDailyWeather(info: (lat:Double,long:Double),completionHandler: @escaping (Result<[DataWrapper],AppError>) -> ()) {
        let urlString = Secrets.getDarkSkyUrl(lat: String(info.lat), long: String(info.long))
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: data)
                    completionHandler(.success(weather.daily.data))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
