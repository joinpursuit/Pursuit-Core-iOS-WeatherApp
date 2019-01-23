//
//  SavedImages.swift
//  WeatherApp
//
//  Created by Stephanie Ramirez on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct SavedImage: Codable {
    let imageData: Data
    let createdAt: String

}
