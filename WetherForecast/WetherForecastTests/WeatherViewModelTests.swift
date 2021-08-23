//
//  WeatherViewModelTests.swift
//  WetherForecastTests
//
//  Created by Nitin Soni on 23/08/21.
//

import XCTest
@testable import WetherForecast

class WeatherViewModelTests: XCTestCase {

    var sut: WeatherDetailsViewModel?
    override func setUpWithError() throws {
        sut = WeatherDetailsViewModel()
        sut?.weatherService = WeatherService(MockService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetWeatherDetails() throws {
        let exp = expectation(description: "weather API")
        sut?.receivedWeatherDetails = { cityWeather in
            XCTAssertNotNil(cityWeather)
            exp.fulfill()
        }
        sut?.getWeatherDetails(cityName: "Pune")
        wait(for: [exp], timeout: 10)
    }
    
    func testGetForecastDetails() throws {
        let exp = expectation(description: "forcast API")
        sut?.receivedWeatherDetails = { cityForecast in
            XCTAssertNotNil(cityForecast)
            exp.fulfill()
        }
        sut?.getWeatherDetails(cityName: "Nagpur")
        wait(for: [exp], timeout: 10)
    }
}
