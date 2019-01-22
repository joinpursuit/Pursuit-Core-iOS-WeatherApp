//
//  WeatherHelper.swift
//  WeatherApp
//
//  Created by Jose Alarcon Chacon on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct WeatherHelper {
    static func dateData(date: String) -> String {
         let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate,
                                                .withFullTime,
                                                .withTimeZone,
                                                .withInternetDateTime,
                                                .withDashSeparatorInDate]
        var formattedDate = date
        if let date = isoDateFormatter.date(from: date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
    static func timeData(time: String) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate,
                                                .withFullTime,
                                                .withTimeZone,
                                                .withInternetDateTime,
                                                .withDashSeparatorInDate]
        var formattedTime = time
        if let date = isoDateFormatter.date(from: time) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            formattedTime = dateFormatter.string(from: date)
        }
        return formattedTime
    }
}

