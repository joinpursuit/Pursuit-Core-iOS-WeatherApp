//
//  CityImages.swift
//  WeatherApp
//
//  Created by Jose Alarcon Chacon on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct CityImages: Codable {
    struct HitWrapper: Codable {
         let largeImageURL: URL
    }
     var hits: [HitWrapper]
}

