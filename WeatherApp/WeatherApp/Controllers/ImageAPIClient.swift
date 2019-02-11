//
//  ImageAPIClient.swift
//  WeatherApp
//
//  Created by Manny Yusuf on 2/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ImagesAPIClient{
    private init() {}
    static func getImages(image: String, completionHandler: @escaping (AppError?, String?) -> Void){
        let endpointString = "https://pixabay.com/api/?key=\(SecretKeys.imageKey)"
        guard let url = URL(string: endpointString) else {
            completionHandler(AppError.badURL(endpointString), nil)
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
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
                    let imageData = try JSONDecoder().decode(weatherImages.self, from: data)
                    completionHandler(nil, imageData.hits.randomElement()?.largeImageURL)
                } catch {
                    completionHandler(AppError.networkError(error), nil)
                }
            }
        }.resume()
    }
}
