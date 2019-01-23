//
//  DateFormatter.swift
//  WeatherApp
//
//  Created by Pritesh Nadiadhara on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

//struct DateFormat {
//    func setDateFromISO(inputDate: Date) -> String {
//        let date = inputDate
//        let isoDateFormatter = ISO8601DateFormatter()
//        isoDateFormatter.formatOptions = [.withFullDate,
//                                          .withFullTime,
//                                          .withInternetDateTime,
//                                          .withTimeZone,
//                                          .withDashSeparatorInDate ]
//        let timeStamp = isoDateFormatter.string(from: date)
//        return timeStamp
//    }
//}

extension String {
    public func formatFromISODateString(dateFormat: String) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = self
        if let date = isoDateFormatter.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
    
    public func dateFromISODateString() -> Date {
        let isoDateFormatter = ISO8601DateFormatter()
        var date = Date()
        if let isoDate = isoDateFormatter.date(from: self) {
            date = isoDate
        }
        return date
    }
}
