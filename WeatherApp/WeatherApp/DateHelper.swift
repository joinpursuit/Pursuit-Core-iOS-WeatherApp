//
//  DateHelper.swift
//  WeatherApp
//
//  Created by Leandro Wauters on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct DateHelper {
    static func getDate(date:String) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate, .withFullTime, .withTimeZone, .withInternetDateTime, .withDashSeparatorInDate]
        var formattedDate = date
        if let date = isoDateFormatter.date(from: date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
  
}
