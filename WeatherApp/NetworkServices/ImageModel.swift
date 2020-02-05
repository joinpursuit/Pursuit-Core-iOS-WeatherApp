//
//  ImageModel.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct Image: Codable {
    let hits: [Hit]
}

struct Hit: Codable & Equatable {
    let largeImageURL: String?
    
}
