//
//  HomeViewModelTests.swift
//  WetherForecastTests
//
//  Created by Nitin Soni on 23/08/21.
//

import XCTest
@testable import WetherForecast

class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel?
    override func setUpWithError() throws {
        sut = HomeViewModel()
        sut?.updatedCities = nil
        sut?.showWeatherDetails = nil
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testAddCityAndRemoveCity() throws {
        sut?.addCity("Pune")
        XCTAssert(!(sut?.cities.isEmpty ?? true), "Test add city failed: empty array")
        XCTAssert(sut?.cities.first == "Pune", "Test add city failed: Cityname not found")
        sut?.removeCity(cityName: "Pune")
        XCTAssert(sut?.cities.isEmpty ?? false, "Test remove city failed: not an empty array")
    }
}
