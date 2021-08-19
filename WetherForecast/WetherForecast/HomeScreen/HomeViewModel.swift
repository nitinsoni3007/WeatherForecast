//
//  HomeViewModel.swift
//  WetherForecast
//
//  Created by Nitin Soni on 19/08/21.
//

import Foundation

//ToDo: we can use combine later
protocol HomeViewModelDelegate {
    func updatedCities()
}

class HomeViewModel {
    var delegate: HomeViewModelDelegate?
    var cities: [String] = [String]() {
        didSet {
            delegate?.updatedCities()
        }
    }
    
    func didSelectCity(cityName: String) {
        print("selected = \(cityName)")
    }
    
    func removeCity(cityName: String) {
        cities.removeAll { name in
            name == cityName
        }
    }
    
    func addCity(_ cityName: String) {
        if !cities.contains(cityName) {
            cities.append(cityName)
        }
    }
}