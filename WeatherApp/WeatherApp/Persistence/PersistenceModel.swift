//
//  PersistenceModel.swift
//  WeatherApp
//
//  Created by Joshua Viera on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class PersistenceModel {
    
    private static let filename = "FavoritedImages.plist"
    private static var fav = [Favorites]()
    
    static func getFav() -> [Favorites] {
        let path = DataPersistanceManager.filepathToDocumentDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    fav = try PropertyListDecoder().decode([Favorites].self, from: data)
                } catch {
                    print("property list decoding error: \(error)")
                }
            } else {
                print("data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        
        return fav
    }
    
    static func addItem(favorite: Favorites) {
        fav.append(favorite)
        save()
    }
    
    static func save() {
        let path = DataPersistanceManager.filepathToDocumentDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(fav)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoder error: \(error)")
        }
    }
}



