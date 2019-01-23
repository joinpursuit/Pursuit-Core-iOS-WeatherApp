//
//  PixabayModel.swift
//  WeatherApp
//
//  Created by Stephanie Ramirez on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct PixabayInfo: Codable{
    let totalHits: Int
    let hits: [Hits]
}
struct Hits: Codable {
    let largeImageURL: String
    let previewURL: String

}
