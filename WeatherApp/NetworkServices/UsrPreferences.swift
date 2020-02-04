//
//  UsrPreferences.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct UserPreferenceKey {
    static let zipCode = ""
}

class UserPreference {

private init() {}

static let shared = UserPreference()

func updateZipcode(with zipcode: String) {
    
    UserDefaults.standard.set(zipcode, forKey: UserPreferenceKey.zipCode)
}

func getZipcode() -> String? {
    guard let zipcode = UserDefaults.standard.object(forKey: UserPreferenceKey.zipCode) as? String else {
        return nil
    }
    return zipcode
}
}
