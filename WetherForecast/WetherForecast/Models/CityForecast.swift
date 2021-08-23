//
//  CityForecast.swift
//
//  Created by Nitin Soni on 22/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct CityForecast: Codable {
  var message: Int?
  var cnt: Int?
  var list: [ForecastList]?
  var fcod: String?
  var city: City?
}

struct ForecastList: Codable {
  enum CodingKeys: String, CodingKey {
    case wind
    case pop
    case weather
    case dtTxt = "dt_txt"
    case visibility
    case dt
    case clouds
    case sys
    case rain
    case main
  }

  var wind: Wind?
  var pop: Float?
  var weather: [Weather]?
  var dtTxt: String?
  var visibility: Int?
  var dt: Int?
  var clouds: Clouds?
  var sys: SysPod?
  var rain: Rain?
  var main: ForeCastMain?
}

struct SysPod: Codable {
    var pod: String?
}

struct Rain: Codable {
    enum CodingKeys: String, CodingKey {
      case threeHour = "3h"
    }

  var threeHour: Float?
}

struct ForeCastMain: Codable {

  enum CodingKeys: String, CodingKey {
    case grndLevel = "grnd_level"
    case tempKf = "temp_kf"
    case temp
    case tempMin = "temp_min"
    case pressure
    case tempMax = "temp_max"
    case feelsLike = "feels_like"
    case seaLevel = "sea_level"
    case humidity
  }

  var grndLevel: Int?
  var tempKf: Float?
  var temp: Float?
  var tempMin: Float?
  var pressure: Int?
  var tempMax: Float?
  var feelsLike: Float?
  var seaLevel: Int?
  var humidity: Int?
}

struct City: Codable {
    var name: String?
    var population: Int?
    var coord: Coord?
    var timezone: Int?
    var country: String?
    var sunset: Int?
    var sunrise: Int?
    var id: Int?
}
