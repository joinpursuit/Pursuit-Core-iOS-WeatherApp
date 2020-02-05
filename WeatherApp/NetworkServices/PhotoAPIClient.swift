//
//  PhotoAPIClient.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import  NetworkHelper

struct ImageAPIClient {
    static func getAllImageInfo(for city: String, completion: @escaping (Result<Image, AppError>) ->()) {
        
//        let searchQuary = searchQuary.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "tacos"
        let imagesEnpointURLString = "https://pixabay.com/api/?key=\(SecretKey.imageApikey)&q=\(city)"
        
        guard let url = URL(string: imagesEnpointURLString) else {
            completion(.failure(.badURL(imagesEnpointURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let images = try JSONDecoder().decode(Image.self, from: data)
                    completion(.success(images))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
