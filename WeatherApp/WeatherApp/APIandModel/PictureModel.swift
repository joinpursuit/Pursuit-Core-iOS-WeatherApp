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
    //let totalHits: Int
    let hits: [Hit]
   // let total: Int
}

// MARK: - Hit
struct Hit: Codable & Equatable {
    let largeImageURL: String?
    let webformatHeight, webformatWidth, likes, imageWidth: Double?
    let id, userID, views, comments: Int
    let pageURL: String
    let imageHeight: Int
    let webformatURL: String
    let type: TypeEnum
    let previewHeight: Int
    let tags: String
    let downloads: Int
    let user: String
    let favorites, imageSize, previewWidth: Int
    let userImageURL: String
    let previewURL: String

    enum CodingKeys: String, CodingKey {
        case largeImageURL, webformatHeight, webformatWidth, likes, imageWidth, id
        case userID = "user_id"
        case views, comments, pageURL, imageHeight, webformatURL, type, previewHeight, tags, downloads, user, favorites, imageSize, previewWidth, userImageURL, previewURL
    }
}

enum TypeEnum: String, Codable {
    case photo = "photo"
}

