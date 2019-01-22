//
//  ImageHelper.swift
//  WeatherApp
//
//  Created by Jose Alarcon Chacon on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit
struct ImageHelper {
    static func weatherImages(icon: String) -> UIImage {
        var getImage = UIImage()
        let image = UIImage.init(named: icon)
        getImage = image!
        return getImage
    }
    
    static func fetchImages(url: URL,completionHandler: @escaping (AppError?, UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error),nil)
            }
            if let data = data {
                var image = UIImage(data: data); completionHandler(nil,image)
            }
            }.resume()
    }
}
