//
//  PictureAPIClient.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct PictureSearchAPIClient {
    static func fetchPicture(with string: String, completion: @escaping(Result<[Hit], AppError>) -> ()) {
        
        let string = string.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "new york"
        
        let pictureEndpointURL = "https://pixabay.com/api/?key=\(SecretKeyForPixabay.apikey2)&q=\(string)&image_type=photo"
        
        guard let url = URL(string: pictureEndpointURL) else {
        completion(.failure(.badURL(pictureEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) {(result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let imageData):
                do {
//                    let searchResults = try JSONDecoder().decode([Hit].self, from: data)
                     let searchResults = try JSONDecoder().decode(Photos.self, from: imageData)
            
                    completion(.success(searchResults.hits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            
        }
    }
}
