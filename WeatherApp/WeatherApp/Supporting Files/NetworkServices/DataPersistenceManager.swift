//
//  DataPersistenceManager.swift
//  WeatherApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class DataPersistenceManager{
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
    }
    
    
    static func filePathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
