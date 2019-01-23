//
//  DataPersistenceManager.swift
//  WeatherApp
//
//  Created by Biron Su on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class DataPersistenceManager {
    private static let filename = "FavoritePhotos.plist"
    
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    static func filepathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
