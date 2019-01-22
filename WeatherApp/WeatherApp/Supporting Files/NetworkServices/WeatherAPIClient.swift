//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class WeatherAPIClient {
    
    static func weatherInformation(zipCode: String,completionHandler: @escaping(Error?,WeatherInformation?) -> Void){
        let endPoint = "https://api.aerisapi.com/forecasts/10453?format=json&filter=day&limit=7&client_id=\(SecretKeys.developerID)&client_secret=\(SecretKeys.developerSecretKey)"
        NetworkHelper.shared.performDataTask(urlString: endPoint, httpMethod: "GET"){ (error, data, httpResponse) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let weather = try JSONDecoder().decode(WeatherInformation.self, from: data)
                    completionHandler(nil, weather)
                } catch {
                    completionHandler(error, nil)
                    print("Decoding Error: \(error)")
                }
            }
        }
    }
    
    
    func getImages(city: String, completionHandler: @escaping(Error?,[ImageDetails]?) -> Void){
        let imageEndpoint = "https://pixabay.com/api/?key=\(SecretKeys.photoKey)&q=Chicago&image_type=photo"
        NetworkHelper.shared.performDataTask(urlString: imageEndpoint, httpMethod: "GET") {(error, data, httpResponse) in
            if let error = error {
                completionHandler(error,nil)
            } else if let data = data {
                do {
                    let image = try JSONDecoder().decode(Image.self, from: data)
                    completionHandler(nil,image.hits)
                } catch {
                    completionHandler(error,nil)
                    print("Decoding Error : \(error)")
                    
                }
            }
        }
    }
    
}

