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
    static func fetchPicture(for search: String, completion: @escaping(Result<[Hit], AppError>) -> ()) {
        
        let searchQuery = search.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let pictureEndpointURL = "https://pixabay.com/api/?key=\(SecretKeyForPixabay.apikey2)&q=\(searchQuery ?? "los angeles")"
        
        guard let url = URL(string: pictureEndpointURL) else {
        completion(.failure(.badURL(pictureEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) {(result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
//                    let searchResults = try JSONDecoder().decode([Hit].self, from: data)
                     let results = try JSONDecoder().decode(Photos.self, from: data)
            
                    completion(.success(results.hits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            
        }
    }
}
