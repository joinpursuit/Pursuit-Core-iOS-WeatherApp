//
//  DataPersistenceManager.swift
//  WeatherApp
//
//  Created by Manny Yusuf on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class DataPersistenceManager {
    private static let filename = "UIImage.plist"
    //paths to documents directory
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func filepathToDocumentDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
