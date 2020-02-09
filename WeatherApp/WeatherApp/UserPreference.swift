//
//  UserPreference.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct UserPreferenceKey {
    static let userZipCode = "User Zipcode"
}

class UserPreference {
    
    private init() {}
    
    static let shared = UserPreference()
    
    func updateUserZipcode(with zipcode: String) {
        UserDefaults.standard.set(zipcode, forKey: UserPreferenceKey.userZipCode)
    }
    
    func getUserZipcode() -> String? {
        guard let userZipCode = UserDefaults.standard.object(forKey: UserPreferenceKey.userZipCode) as? String else {
            return nil
        }
        return userZipCode
    }
}
