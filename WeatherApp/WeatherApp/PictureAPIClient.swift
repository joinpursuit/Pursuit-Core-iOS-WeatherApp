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
    static func fetchPicture(for searchQuery: String, completion: @escaping(Result<[Hit], AppError>) -> ()) {
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "uk"
        
        let pictureEndpointURL = "https://pixabay.com/api/?key=\(SecretKeyForPixabay.apikey2)&q=\(searchQuery)&image_type=photo"
        
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
                    let searchResults = try JSONDecoder().decode([Hit].self, from: data)
                    
                  // Add how to map through countries
                    //let countries = searchResults.ma
                    completion(.success(searchResults))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            
        }
    }
}
