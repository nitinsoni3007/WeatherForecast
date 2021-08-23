//
//  WeatherServiceTests.swift
//  WetherForecastTests
//
//  Created by Nitin Soni on 23/08/21.
//

import XCTest
@testable import WetherForecast

class WeatherServiceTests: XCTestCase {
    var sut: WeatherService?

    override func setUpWithError() throws {
        sut = WeatherService(MockService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetCityForcast() throws {
        sut?.getForeCastDetials("Nagpur", temperatureUnit: .metric, completion: { result in
            switch result {
            case .success(let cityForecast):
                XCTAssertNotNil(cityForecast)
            case .failure:
                XCTFail("Forecast API consumption or decoding failed")
            }
        })
    }

    func testGetWeatherDetails() throws {
        sut?.getWeatherDetail("Pune", temperatureUnit: .metric, completion: { result in
            switch result {
            case .success(let cityWeather):
                XCTAssertNotNil(cityWeather)
            case .failure:
                XCTFail("Weather API consumption or decoding failed")
            }
        })
    }
}
