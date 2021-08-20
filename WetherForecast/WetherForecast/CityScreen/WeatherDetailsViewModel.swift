//
//  WeatherDetailsViewModel.swift
//  WetherForecast
//
//  Created by Nitin Soni on 20/08/21.
//

import Foundation

protocol WeatherDetailsViewModelDelegate {
    func receivedWeatherDetails(_ cityWeather: CityWeather)
    func failedToReceiveWeatherDetails(_ error: APIError)
}

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
//    var error: String?
    var cityWeather: CityWeather?
    var delegate: WeatherDetailsViewModelDelegate?
    var weatherService = WeatherService()
    
    func getWeatherDetails(cityName: String) {
        weatherService.getWeatherDetail(cityName, temperatureUnit: .metric) { [weak self] result in
            guard let weakSelf = self else {return}
            switch result {
            case .success(let cityWeather):
                weakSelf.cityWeather = cityWeather
                weakSelf.delegate?.receivedWeatherDetails(cityWeather)
            case .failure(let error):
                weakSelf.delegate?.failedToReceiveWeatherDetails(error)
            }
        }
    }
    
    func getForecastDetails(cityName: String) {
        
    }
}