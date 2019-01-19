//
//  FavoritedImage.swift
//  WeatherApp
//
//  Created by Jane Zhu on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct FavoritedImage: Codable {
    let lastUpdated: String
    let imageData: Data
    
    public var date: Date {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = Date()
        if let date = isoDateFormatter.date(from: lastUpdated) {
            formattedDate = date
        }
        return formattedDate
    }
}
