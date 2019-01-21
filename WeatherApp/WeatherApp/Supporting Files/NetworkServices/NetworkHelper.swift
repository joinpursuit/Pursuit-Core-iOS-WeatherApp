//
//  NetworkHelper.swift
//  WeatherApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class NetworkHelper {
    
    private init(){
        
        let cache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 10 * 1024 * 1024, diskPath: nil)
        URLCache.shared = cache

    }
    
    public static let shared = NetworkHelper()
    public func performDataTask(urlString: String, httpMethod: String, completionHandler: @escaping (AppError?, Data?, HTTPURLResponse?) -> Void) {
        guard let url = URL.init(string: urlString) else {
            print("BadUrl: \(urlString)")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil, nil)
            }
            if let response = response as? HTTPURLResponse{
                print("Response Status \(response.statusCode)")
            }
            if let data = data {
                completionHandler(nil, data, response as? HTTPURLResponse)
            }
        }.resume()
    }
    
    
}

