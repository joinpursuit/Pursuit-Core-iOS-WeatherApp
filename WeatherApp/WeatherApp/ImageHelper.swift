//
//  ImageHelper.swift
//  WeatherApp
//
//  Created by Leandro Wauters on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

struct ImageHelper{
    static func getWeatherImage(icon: String) -> UIImage {
        var imageToReturn = UIImage()
        if let image = UIImage.init(named: icon) {
            imageToReturn = image
        }
        return imageToReturn
    }

        
    static func fetchImage(url: URL, completionHandler: @escaping (AppError?, UIImage?) -> Void) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completionHandler(AppError.networkError(error), nil)
                }
                if let data = data{
                    let image = UIImage(data: data)
                    completionHandler(nil, image)
                }
            }.resume()
        }
    
}
