//
//  StubGenerator.swift
//  WetherForecastTests
//
//  Created by Nitin Soni on 23/08/21.
//

import Foundation
@testable import WetherForecast

class StubGenerator {
    func getForecastDetails(cityName: String) -> CityForecast? {
        let bundle = Bundle(for: StubGenerator.self)
        guard let jsonFile = bundle.path(forResource: "CityForcastResponse", ofType: "json") else {return nil}
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFile))
            do {
                let json = try JSONDecoder().decode(CityForecast.self, from: jsonData)
                return json
            }catch {
                return nil
            }
        }catch {
            return nil
        }
    }
    
    func getWeatherDetails(cityName: String) -> CityWeather? {
        let bundle = Bundle(for: StubGenerator.self)
        guard let jsonFile = bundle.path(forResource: "CityWeatherResponse", ofType: "json") else {return nil}
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFile))
            do {
                let json = try JSONDecoder().decode(CityWeather.self, from: jsonData)
                return json
            }catch {
                return nil
            }
        }catch {
            return nil
        }
    }
}
