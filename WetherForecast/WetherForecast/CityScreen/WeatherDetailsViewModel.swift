//
//  WeatherDetailsViewModel.swift
//  WetherForecast
//
//  Created by Nitin Soni on 20/08/21.
//

import Foundation

enum TempratureUnit: String {
    case metric = "metric"
    case imperial = "imperial"
    case standard = "standard"
    
    func symbol() -> String {
        switch self {
        case .metric:
            return "\u{00B0}C"
        case .imperial:
            return "\u{00B0}F"
        case .standard:
            return "K"
        }
    }
}

class WeatherDetailsViewModel {
    var cityName: String?
    var currentTempUnit: TempratureUnit = .metric
    var cityWeather: CityWeather?
    var cityForecastResponse: CityForecast?
    var weatherService = WeatherService()
    var receivedWeatherDetails: ((CityWeather) -> Void)?
    var failedToReceiveWeatherDetails: ((APIError) -> Void)?
    var recievedCityForecast: ((CityForecast) -> Void)?
    var failedToRecieveForecast: ((APIError) -> Void)?
    
    func getWeatherDetails(cityName: String) {
        weatherService.getWeatherDetail(cityName, temperatureUnit: .metric) { [weak self] result in
            guard let weakSelf = self else {return}
            switch result {
            case .success(let cityWeather):
                weakSelf.cityWeather = cityWeather
                weakSelf.receivedWeatherDetails?(cityWeather)
            case .failure(let error):
                weakSelf.failedToReceiveWeatherDetails?(error)
            }
            self?.getForecastDetails(cityName: cityName)
        }
    }
    
    func getForecastDetails(cityName: String) {
        weatherService.getForeCastDetials(cityName, temperatureUnit: .metric) { [weak self]result in
            guard let weakSelf = self else {return}
            switch result {
            case .success(let cityForecast):
                weakSelf.cityForecastResponse = cityForecast
                weakSelf.recievedCityForecast?(cityForecast)
            case .failure(let error):
                weakSelf.failedToRecieveForecast?(error)
            }
        }
    }
}
