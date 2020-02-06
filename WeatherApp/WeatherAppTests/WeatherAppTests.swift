//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Ahad Islam on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import XCTest
import CoreLocation
import DataPersistence
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    func testJSONFromEndpoint() {
        let endpointURL = "https://pixabay.com/api/?key=\(APIKey.pixabayKey)&q=yellow+flowers"
        let exp = XCTestExpectation(description: "Something")
        
        GenericCoderAPI.manager.getJSON(objectType: PixWrapper.self, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                XCTFail("Failure to decode JSON: \(error)")
            case .success:
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 5)
    }
    
    func testJSON2FromEndpoint() {
        var forecast: Forecast? = nil
        let endpointURL = "https://api.darksky.net/forecast/\(APIKey.darkSkyKey)/37.8267,-122.4233"
        let exp = XCTestExpectation(description: "Failed to something")
        
        GenericCoderAPI.manager.getJSON(objectType: Forecast.self, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                XCTFail("Failed to get JSON: \(error)")
            case .success(let forecastFromAPI):
                forecast = forecastFromAPI
                XCTAssertNotNil(forecast)
                exp.fulfill()
            }
        }
    }
    
    func testZipCodeHelper() {
        var location: (lat: Double, long: Double, placeName: String) = (0, 0, "a")
        
        ZipCodeHelper.getLatLong(fromZipCode: "11365") { result in
            switch result {
            case .failure(let error):
                XCTFail("\(error)")
            case .success(let tuple):
                location = tuple
                print(location)
                print("Lat: \(location.lat), Long: \(location.long), Place: \(location.placeName)")
                print("OKKKK")
            }
        }
    }
    
    func testZipcodeToCoordinates() {
      // arrange
      let zipcode = "10023"
      
      let exp = XCTestExpectation(description: "zipcode parsed")
      
      // act
      ZipCodeHelper.getLatLong(fromZipCode: zipcode) { (result) in
        switch result {
        case .failure(let fetchingError):
          XCTFail("coordinates fetching error: \(fetchingError)")
        case .success(let coordinate):
          // assert
          XCTAssertEqual(coordinate.lat, 40.7754123)
          exp.fulfill()
        }
      }
      
      wait(for: [exp], timeout: 3.0)
    }
    
    func testDelete() {
        let dataPersistence = DataPersistence<ImageObject>(filename: "favorites.plist")
        let images = try! dataPersistence.loadItems()
        try! dataPersistence.deleteItem(at: images.count - 1)
    }

}
