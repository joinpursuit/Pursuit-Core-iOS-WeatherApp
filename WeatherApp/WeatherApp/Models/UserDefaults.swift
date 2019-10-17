//
//  UserDefaults.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
class UserDefaultWrapper {
    
    private init () {}
    
    static let manager = UserDefaultWrapper()
    
    //MARK: Keys
    private let zipCodeKey = "zipcode"
    
    //MARK: Sets
    func set(value: String) {
        UserDefaults.standard.set(value, forKey: zipCodeKey)
    }
    
    //MARK: Gets
    func getZipCode() -> String? {
        if let value = UserDefaults.standard.value(forKey: zipCodeKey) as? String {
            return value
        }
        return nil
    }
    
}
