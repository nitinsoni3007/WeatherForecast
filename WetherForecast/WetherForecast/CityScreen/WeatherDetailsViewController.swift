//
//  WeatherDetailsViewController.swift
//  WetherForecast
//
//  Created by Nitin Soni on 20/08/21.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherTitleLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windspeedLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var cityName: String?
    var arrForcastList: [ForecastList]?
    var collectionViewCellReusableIdentifier = "ForecastCell"
    lazy var viewmodel: WeatherDetailsViewModel = {
        WeatherDetailsViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = cityName
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let city = cityName {
        viewmodel.getWeatherDetails(cityName: city)
        }
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()

            if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.itemSize = CGSize(width: 120, height: 120)
            }
        }
}

extension WeatherDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrForcastList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellReusableIdentifier, for: indexPath) as? ForecastCell else {
            return UICollectionViewCell()
        }
        cell.viewmodel = viewmodel
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.white : UIColor.lightGray
        if let forecast = self.arrForcastList?[indexPath.item] {
        cell.configure(forecast)
        }
        return cell
    }
}

extension WeatherDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
}

extension WeatherDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 120, height: 120)
    }
}

extension WeatherDetailsViewController {
    func bindViewModel() {
        self.viewmodel.receivedWeatherDetails = { cityWeather in
            if let temp = cityWeather.main?.temp {
                let unitSymbol = self.viewmodel.currentTempUnit.symbol()
                DispatchQueue.main.async {
                    self.temperatureLabel.text = "\(Int(round(temp)))\(unitSymbol)"
                    self.weatherTitleLabel.text = cityWeather.weather?[0].descriptionValue
                    if let humidity = cityWeather.main?.humidity {
                    self.humidityLabel.text = "\(humidity)"
                    }
                    if let windSpeed = cityWeather.wind?.speed {
                    self.windspeedLabel.text = "\(windSpeed)"
                    }
                }
            }
        }
        
        self.viewmodel.recievedCityForecast = { cityforecast in
            if let arrList = cityforecast.list {
            
            let filteredList = arrList.filter {$0.dtTxt?.components(separatedBy: " ").last == "09:00:00"}
                self.arrForcastList = filteredList
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        self.viewmodel.failedToReceiveWeatherDetails = { error in
            print("error = \(error)")
        }
        
        self.viewmodel.failedToRecieveForecast = { error in
            print("error = \(error)")
        }
    }
}
