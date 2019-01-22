//
//  DataPresistenceManager.swift
//  WeatherApp
//
//  Created by Jose Alarcon Chacon on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
final class DataPresistenceManager {
    static func documentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    static func filePathToDocumentDirectory(filename: String) -> URL {
        return documentDirectory().appendingPathComponent(filename)
    }
}
