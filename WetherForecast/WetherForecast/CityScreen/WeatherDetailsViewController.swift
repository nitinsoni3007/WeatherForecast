//
//  WeatherDetailsViewController.swift
//  WetherForecast
//
//  Created by Nitin Soni on 20/08/21.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    var cityName: String?
    lazy var viewmodel: WeatherDetailsViewModel = {
        WeatherDetailsViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        temperatureLabel.text = "27\u{00B0}C"
        navigationItem.title = cityName
        viewmodel.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let city = cityName {
        viewmodel.getWeatherDetails(cityName: city)
        }
    }

}

extension WeatherDetailsViewController: WeatherDetailsViewModelDelegate {
    func receivedWeatherDetails(_ cityWeather: CityWeather) {
        if let temp = cityWeather.main?.temp {
            let unitSymbol = viewmodel.currentTempUnit.symbol()
            DispatchQueue.main.async {
                self.temperatureLabel.text = "\(Int(temp))\(unitSymbol)"
            }
        }
    }
    
    func failedToReceiveWeatherDetails(_ error: APIError) {
        print("error: \(error.localizedDescription)")
    }
}
