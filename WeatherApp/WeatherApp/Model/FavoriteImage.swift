//
//  FavoriteImage.swift
//  WeatherApp
//
//  Created by Leandro Wauters on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct FavoriteImage: Codable {
    let favoritedAt: String
    let imageData: Data
    
    public var date: Date{
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = Date()
        if let date = isoDateFormatter.date(from: favoritedAt) {
            formattedDate = date
        }
        return formattedDate
    }
}
