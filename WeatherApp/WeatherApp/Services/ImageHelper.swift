//
//  ImageHelper.swift
//  WeatherApp
//
//  Created by Stephanie Ramirez on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

final class ImageHelper {
    private init() {
        imageCache = NSCache<NSString, UIImage>()
        imageCache.countLimit = 100 // number of objects
        imageCache.totalCostLimit = 10 * 1024 * 1024 // max 10MB used
    }
    public static let shared = ImageHelper()
    
    private var imageCache: NSCache<NSString, UIImage>
    
    public func fetchImage(urlString: String, completionHandler: @escaping (AppError?, UIImage?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: urlString) { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
                return
            }
            if let response = response {
                let mimeType = response.mimeType ?? "no mimeType found"
                var isValidImage = false
                switch mimeType {
                case "image/jpeg":
                    isValidImage = true
                case "image/png":
                    isValidImage = true
                default:
                    isValidImage = false
                }
                if !isValidImage {
                    completionHandler(AppError.badMimeType(mimeType), nil)
                    return
                } else if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        if let image = image {
                            ImageHelper.shared.imageCache.setObject(image, forKey: urlString as NSString)
                        }
                        completionHandler(nil, image)
                    }
                }
            }
        }
    }
    
    public func image(forKey key: NSString) -> UIImage? {
        return imageCache.object(forKey: key)
    }
}
