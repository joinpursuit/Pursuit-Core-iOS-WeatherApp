//
//  PixabyHelper.swift
//  WeatherApp
//
//  Created by Jane Zhu on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

final class PixabayAPIClient {
    private init() {}
    
    static func getImageURLString(ofLocation: String, completionHandler: @escaping (AppError?, String?) -> Void) {
        let endpointURLString = "https://pixabay.com/api/?key=11327400-0df301945e305d94d5f34b096&q=\(ofLocation)"
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
                    let imageData = try JSONDecoder().decode(PixabayImageData.self, from: data)
                    completionHandler(nil, imageData.hits[Int.random(in: 0...imageData.totalHits - 1)].largeImageURL)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }.resume()
    }
}
