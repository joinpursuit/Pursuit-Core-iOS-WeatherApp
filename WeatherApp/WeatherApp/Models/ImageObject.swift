//
//  ImageObject.swift
//  WeatherApp
//
//  Created by Ahad Islam on 2/6/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct ImageObject: Codable, Equatable {
    let name: String
    let imageData: Data
    let identifier = UUID().uuidString
}
