//
//  MockService.swift
//  WetherForecastTests
//
//  Created by Nitin Soni on 23/08/21.
//

import Foundation
@testable import WetherForecast

class MockService: BaseServiceProtocol {
    func get<S, F>(urlString: String, headers: [String: String]?, queryParams: [String: Any]?, success: S.Type, failure: F.Type, _ completion: @escaping (Result<S, APIError>) -> Void) where S:Decodable, F:Decodable {
        if urlString.hasPrefix(Constants.APIs.forcastAPI) {
            if let cityForcast = StubGenerator().getForecastDetails(cityName: "Nagpur") as? S {
                completion(.success(cityForcast))
            }
        } else if urlString.hasPrefix(Constants.APIs.weatherDetailAPI) {
            if let cityWeather = StubGenerator().getWeatherDetails(cityName: "Pune") as? S {
                completion(.success(cityWeather))
            }
        }
        
    }
}
