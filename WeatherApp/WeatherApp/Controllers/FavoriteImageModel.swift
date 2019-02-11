//
//  FavoriteImageModel.swift
//  WeatherApp
//
//  Created by Manny Yusuf on 2/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class FavoriteImageModel {
    private static let filename = "FavoritePhotos.plist"
    static var favoritePhotos = [Data]()
    
    private init() {}
    
    static func saveImage() {
        let path = DataPersistenceManager.filepathToDocumentDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(favoritePhotos)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("Property list encoding error: \(error)")
        }
    }
    static func addImage(image: Data) {
        favoritePhotos.append(image)
        saveImage()
    }
    static func getImages() -> [Data] {
        let path = DataPersistenceManager.filepathToDocumentDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    favoritePhotos = try PropertyListDecoder().decode([Data].self, from: data)
                } catch {
                    print("Property list decoding error: \(error)")
                }
            } else {
                print("Data does not exist...")
            }
        } else {
            print("\(filename) does not exist...")
        }
        return favoritePhotos
    }
}
