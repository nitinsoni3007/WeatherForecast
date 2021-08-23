//
//  Constants.swift
//  WetherForecast
//
//  Created by Nitin Soni on 20/08/21.
//

import Foundation

struct Constants {
    static let apiKey = "fae7190d7e6433ec3a45285ffcf55c86"
    struct APIs {
        static let weatherDetailAPI = "https://api.openweathermap.org/data/2.5/weather"
        static let forcastAPI = "https://api.openweathermap.org/data/2.5/forecast"
    }
    
    struct unitSymbols {
        static let celsius = "\u{00B0}C"
        static let ferenhite = "\u{00B0}F"
    }
}
