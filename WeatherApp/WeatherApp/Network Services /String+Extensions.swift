//
//  String+Extensions.swift
//  WeatherApp
//
//  Created by Manny Yusuf on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct WeatherDateHelper {
    static func formatISOToDate(dateString: String) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = dateString
        if let date = isoDateFormatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
        
    }
    static func formatISOToTime(dateString: String) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = dateString
        if let date = isoDateFormatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
}
