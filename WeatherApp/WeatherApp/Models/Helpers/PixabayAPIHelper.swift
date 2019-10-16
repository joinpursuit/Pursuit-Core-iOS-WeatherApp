//
//  PixibayAPIHelper.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
class PixabayAPIHelper {
    private init() {}
    static let manager = PixabayAPIHelper()
    func getOnePictureUrl(nameOfPlace: String, completionHandler: @escaping (Result<String,AppError>) -> ()) {
        let urlString = Secrets.getPixabayUrlWith(query: nameOfPlace)
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
                    let pixabayWrapper = try JSONDecoder().decode(PhotoWrapper.self, from: data)
                    if pixabayWrapper.hits.count > 0 {
                        if let randomUrl = pixabayWrapper.hits.randomElement() {
                            completionHandler(.success(randomUrl.webformatURL))
                        }
                    } else {
                        completionHandler(.failure(.badURL))
                    }
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
