//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Stephanie Ramirez on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class WeatherAPIClient {

    private init() {}
    static func searchZipcode(zipcode: String, isZipcode: Bool, completionHandler: @escaping (AppError?, [Response]?) -> Void) {
        
        var endpointURLString = ""
        if isZipcode {
            endpointURLString = "http://api.aerisapi.com/forecasts/\(zipcode)?client_id=\(SecretKeys.accessID)&client_secret=\(SecretKeys.secretKey)"
        } else {
            return
        }

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
                    let dayInfo = try JSONDecoder().decode(DayInfo.self, from: data)
                    completionHandler(nil, dayInfo.response)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
            }.resume()
    }
    static func searchImage(location: String, completionHandler: @escaping (AppError?, String?) -> Void) {
        print(location)
        guard let keyword = location.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        print(keyword)
        let endpointURLString = "https://pixabay.com/api/?key=\(SecretKeys.pixabayKey)&q=\(keyword)"
            
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
                    let pixaBayInfo = try JSONDecoder().decode(PixabayInfo.self, from: data)

                    completionHandler(nil, pixaBayInfo.hits[Int.random(in:0...pixaBayInfo.hits.count-1)].largeImageURL)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
            }.resume()
    }
}
