//
//  ImageClientAPI.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


final class ImagesClientAPI {
  
  static func searchImage(selectedCityName: String, completionHandler: @escaping (AppError?, [ImageDetailedInfo]?) -> Void){
    
    let city = selectedCityName.replacingOccurrences(of: " ", with: "+")
    
    let urlString = "https://pixabay.com/api/?key=\(Constants.imageAPIKey)&q=\(city)&image_type=photo"
    
    NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
      
      if let appError = appError {
        completionHandler(appError, nil)
      }
      guard let response = httpResponse,
        (200...299).contains(response.statusCode) else {
          let statusCode = httpResponse?.statusCode ?? -999
          completionHandler(AppError.badStatusCode(String(statusCode)), nil)
          return
      }
      if let data = data {
        do {
          let imageData = try JSONDecoder().decode(ImageModel.self, from: data)
          completionHandler(nil, imageData.hits)
        } catch {
          completionHandler(AppError.decodingError(error), nil)
        }
      }
    }
  }
  
}

//
//static func getCity(selectedCity: String,completionHandler: @escaping((AppError?, [CityImages.HitWrapper]?) -> Void)) {
//  let city = selectedCity.replacingOccurrences(of: " " , with: "+")
//  let endpointURLString = "https://pixabay.com/api/?key=\(SecretKeys.CityAPIKey)&q=\(city)&image_type=photo"
//
//  guard let url = URL(string: endpointURLString) else {
//    completionHandler(AppError.badURL(endpointURLString),nil)
//    return
//  }
//  let request = URLRequest(url: url)
//  URLSession.shared.dataTask(with: request) { (data, response, error) in
//    if let error = error {
//      completionHandler(AppError.networkError(error), nil)
//    }
//    guard let httpResponse = response as? HTTPURLResponse,
//      (200...299).contains(httpResponse.statusCode) else {
//        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
//        completionHandler(AppError.badStatusCode("\(statusCode)"), nil)
//        return
//    }
//    if let data = data {
//      do {
//        let data = try JSONDecoder().decode(CityImages.self, from: data)
//        completionHandler(nil,data.hits)
//      } catch {
//        completionHandler(AppError.jsonDecodingError(error),nil)
//      }
//    }
//    }.resume()
//}
//}
