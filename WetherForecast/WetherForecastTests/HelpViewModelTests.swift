//
//  HelpViewModelTests.swift
//  WetherForecastTests
//
//  Created by Nitin Soni on 23/08/21.
//

import XCTest
@testable import WetherForecast

class HelpViewModelTests: XCTestCase {

    var sut: HelpViewModel?
    override func setUpWithError() throws {
        sut = HelpViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetHelpScreenRequestToLoad() throws {
        let exp = expectation(description: "expecting url")
        sut?.getHelpScreenRequestToLoad { req in
            XCTAssertNotNil(req)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
}
