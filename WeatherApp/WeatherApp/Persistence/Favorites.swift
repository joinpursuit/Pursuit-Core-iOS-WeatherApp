//
//  Favorites.swift
//  WeatherApp
//
//  Created by Joshua Viera on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Favorites : Codable {
    let createdAt: String
    let imageData: Data
    
    public var dateFormattedString: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = createdAt
        if let date = isoDateFormatter.date(from: createdAt){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyy hh:mm a"
            formattedDate = dateFormatter.string(from: date)
            
        }
        return formattedDate
    }
    public var date: Date{
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = Date()
        if let date = isoDateFormatter.date(from: createdAt){
            formattedDate  = date
        }
        return formattedDate
    }
}
