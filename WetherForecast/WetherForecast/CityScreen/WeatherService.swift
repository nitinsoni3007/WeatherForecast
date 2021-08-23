//
//  WeatherService.swift
//  WetherForecast
//
//  Created by Nitin Soni on 20/08/21.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeatherDetail(_ cityName: String, temperatureUnit: TempratureUnit, completion: @escaping (Result<CityWeather, APIError>) -> Void)
    func getForeCastDetials(_ cityName: String, temperatureUnit: TempratureUnit, completion: @escaping (Result<CityForecast, APIError>) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    // BaseService object below can be mocked
    var baseService: BaseServiceProtocol?
    init(_ baseService: BaseServiceProtocol? = BaseService()) {
        self.baseService = baseService
    }
    // Calls Get current weather API for selected city
    func getWeatherDetail(_ cityName: String, temperatureUnit: TempratureUnit, completion: @escaping (Result<CityWeather, APIError>) -> Void) {
        let parameters = createQueryParameters(cityName, temperatureUnit: temperatureUnit)
        baseService?.get(urlString: Constants.APIs.weatherDetailAPI, headers: nil, queryParams: parameters, success: CityWeather.self, failure: APIError.self, completion)
    }
    
    func getForeCastDetials(_ cityName: String, temperatureUnit: TempratureUnit, completion: @escaping (Result<CityForecast, APIError>) -> Void) {
        let parameters = createQueryParameters(cityName, temperatureUnit: temperatureUnit)
        baseService?.get(urlString: Constants.APIs.forcastAPI, headers: nil, queryParams: parameters, success: CityForecast.self, failure: APIError.self, completion)
    }
    
    private func createQueryParameters(_ cityName: String, temperatureUnit: TempratureUnit? = .metric) -> [String: Any]? {
        var parameters = [
            "q": cityName,
            "appid": Constants.apiKey
        ]
        if let unit = temperatureUnit {
            parameters["units"] = unit.rawValue
        }
        return parameters
    }
}
