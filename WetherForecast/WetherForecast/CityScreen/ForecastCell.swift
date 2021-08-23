//
//  forcastCell.swift
//  WetherForecast
//
//  Created by Nitin Soni on 23/08/21.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    var viewmodel: WeatherDetailsViewModel?
    
    func configure(_ forecast: ForecastList) {
        if let dateString = forecast.dtTxt?.components(separatedBy: " ").first {
            let parts = dateString.components(separatedBy: "-")
            dateLabel.text = "\(parts[1])/\(parts[2])"
        if let temperature = forecast.main?.temp,
           let unitSymbol = viewmodel?.currentTempUnit.symbol() {
            let tempInInt = Int(round(temperature))
            temperatureLabel.text = "\(tempInInt)" + "\(String(describing: unitSymbol))"
        }
        }
    }
}
