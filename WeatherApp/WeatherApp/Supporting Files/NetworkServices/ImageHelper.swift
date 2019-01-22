//
//  ImageHelper.swift
//  WeatherApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

public final class ImageHelper {
    private init(){
        imageCache = NSCache<NSString, UIImage>()
        imageCache.countLimit = 100
        imageCache.totalCostLimit = 10 * 1024 * 1024
    }
    public static let shared = ImageHelper()
    private var imageCache: NSCache<NSString, UIImage>
    
    public func fetchImage(urlString: String, completionHandler:@escaping(AppError?, UIImage?) -> Void){
        NetworkHelper.shared.performDataTask(urlString: urlString, httpMethod: "GET") { (error, data, response) in
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
