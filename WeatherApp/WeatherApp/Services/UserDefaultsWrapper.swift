//
//  UserDefaultsWrapper.swift
//  userDefaultslab
//
//  Created by Ahad Islam on 12/25/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

class UserDefaultsWrapper {
    
    static let helper = UserDefaultsWrapper()
    
    private let zipcodeKey = "zipcode"
    
    private init () {}
    
    func store(zipcode: String) {
        UserDefaults.standard.set(zipcode, forKey: zipcodeKey)
    }
    
    func getZipcode() -> String? {
        UserDefaults.standard.string(forKey: zipcodeKey)
    }
    
}
