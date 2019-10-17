//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Angela Garrovillas on 10/14/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import XCTest
import CoreLocation
@testable import WeatherApp
class WeatherAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testZipCodeHelper() {
        var lat = Double() {
            didSet {
                XCTAssertTrue(false, "lat: \(lat)")
            }
        }
        ZipCodeHelper.getLatLong(fromZipCode: "11102") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertTrue(false, "got error: \(error)")
            case .success(let info):
                DispatchQueue.main.async {
                    lat = info.lat
                }
                
            }
        }
        //XCTAssertTrue(false, "\(lat)")
    }
    func testDataWrapper() {
        let testSample = DataWrapper(time: 1571198400, summary: "Heavy rain starting in the afternoon.", icon: "rain", temperatureHigh: 68.62, temperatureLow: 48.94, sunriseTime: 1571224144, sunsetTime: 1571264140, windSpeed: 10.77, precipIntensityMax: 0.5187)
        XCTAssertTrue(testSample.icon == "rain", "was expecting 'rain' but got \(testSample.icon)")
    }
    func testDateConverter() {
        let testSample = DataWrapper(time: 1571198400, summary: "Heavy rain starting in the afternoon.", icon: "rain", temperatureHigh: 68.62, temperatureLow: 48.94, sunriseTime: 1571224144, sunsetTime: 1571264140, windSpeed: 10.77, precipIntensityMax: 0.5187)
        
        let testdate = testSample.convertTimeToDate(time: testSample.time)
        let testSunrise = testSample.convertSunTime(time: testSample.sunriseTime)
        let testSunset = testSample.convertSunTime(time: testSample.sunsetTime)
        
        let actual = "2019-10-16"
        let actualSunrise = "11:09 AM"
        let actualSunset = "10:15 PM"
        
        XCTAssertTrue(testdate == actual, "was expecting '2019-10-16' but got \(testdate)")
        XCTAssertTrue(testSunrise == actualSunrise, "was expecting '11:09 AM' but got \(testSunrise)")
        XCTAssertTrue(testSunset == actualSunset, "was expecting '11:09 AM' but got \(testSunset)")
    }
    func testImageFromForcast() {
        let picForRain = getImageFrom(forcast: "rain")
        XCTAssertTrue(picForRain == #imageLiteral(resourceName: "rainn"), "did not get right pic")
    }

}
