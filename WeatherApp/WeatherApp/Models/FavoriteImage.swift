//
//  FavoriteImage.swift
//  WeatherApp
//
//  Created by Jeffrey Almonte on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct FavoriteImage: Codable {
    let hits: [ImageDetailedInfo]
   
}
struct ImageDetailedInfo: Codable {
    let largeImageURL: String
   // let user: String
   // let id: Int
    
}
