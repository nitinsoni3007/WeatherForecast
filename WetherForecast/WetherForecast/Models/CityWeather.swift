//
//  CityWeather.swift
//  WetherForecast
//
//  Created by Nitin Soni on 20/08/21.
//

import Foundation

struct CityWeather: Codable {
    var cod: Int?
    var weather: [Weather]?
    var name: String?
    var id: Int?
    var base: String?
    var clouds: Clouds?
    var visibility: Int?
    var coord: Coord?
    var main: Main?
    var timezone: Int?
    var sys: Sys?
    var dt: Int?
    var wind: Wind?
}

struct Coord: Codable {
    var lon: Float?
    var lat: Float?
}

struct Weather: Codable {
    enum CodingKeys: String, CodingKey {
      case main
      case id
      case descriptionValue = "description"
      case icon
    }

    var main: String?
    var id: Int?
    var descriptionValue: String?
    var icon: String?
}

struct Clouds: Codable {
    var all: Int?
}

struct Main: Codable {
    enum CodingKeys: String, CodingKey {
      case feelsLike = "feels_like"
      case temp
      case seaLevel = "sea_level"
      case pressure
      case grndLevel = "grnd_level"
      case tempMin = "temp_min"
      case humidity
      case tempMax = "temp_max"
    }

    var feelsLike: Float?
    var temp: Float?
    var seaLevel: Int?
    var pressure: Int?
    var grndLevel: Int?
    var tempMin: Float?
    var humidity: Int?
    var tempMax: Float?
}

struct Sys: Codable {
    var sunrise: Int?
    var id: Int?
    var type: Int?
    var sunset: Int?
    var country: String?
}

struct Wind: Codable {
    var gust: Float?
    var deg: Int?
    var speed: Float?
}
