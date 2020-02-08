//
//  PictureModel.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

// MARK: - Photos
struct Photos: Codable & Equatable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable & Equatable {
    let largeImageURL: String
}


