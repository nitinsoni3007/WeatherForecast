//
//  HomeViewController.swift
//  WetherForecast
//
//  Created by Nitin Soni on 19/08/21.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var noCityAddedLabel: UILabel!
    var reusableIdentifierCityCell = "CityCell"
    var cityPin = MKPointAnnotation()
    lazy var viewModel: HomeViewModel = {
        HomeViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableview.register(UINib(nibName: String(describing: CityCell.self), bundle: Bundle.main), forCellReuseIdentifier: reusableIdentifierCityCell)
    }
    
    func refreshHomeScreen() {
        if viewModel.cities.isEmpty {
            noCityAddedLabel.isHidden = false
        } else {
            noCityAddedLabel.isHidden = true
            tableview.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addGestureToMapView()
        refreshHomeScreen()
        showHelpScreen()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let longPress = mapView.gestureRecognizers?.first {
            mapView.removeGestureRecognizer(longPress)
        }
    }
    
    func showHelpScreen() {
        guard let helpVC = storyboard?.instantiateViewController(identifier: "HelpViewController") as? HelpViewController else {return}
        helpVC.view.backgroundColor = UIColor.clear
        self.addChild(helpVC)
        self.view.addSubview(helpVC.view)
        helpVC.didMove(toParent: self)
    }
    
    //MARK: MapView functions
    func addGestureToMapView() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(_:)))
        longPress.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPress)
    }
    
    @objc func longPressed(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .ended {
            mapView.removeAnnotation(cityPin)
            let touchPoint = recognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
            showConfirmation(location)
            print("coordinate = \(location)")
            cityPin.coordinate = location.coordinate
            mapView.addAnnotation(cityPin)
        }
    }
    
    func showConfirmation(_ location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { placeMarks, error in
            if error == nil, let placeMark = placeMarks?.first {
                if let cityName = placeMark.locality {
                    self.viewModel.addCity(cityName)
                }
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: reusableIdentifierCityCell) as? CityCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.cities[indexPath.row])
        cell.viewModel = self.viewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCity(cityName: viewModel.cities[indexPath.row])
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func updatedCities() {
        refreshHomeScreen()
    }
    
    func showWeatherDetails(cityName: String) {
        guard let weatherDetailsVC = storyboard?.instantiateViewController(identifier: "WeatherDetailsViewController") as? WeatherDetailsViewController else {
            return
        }
        weatherDetailsVC.cityName = cityName
        navigationController?.pushViewController(weatherDetailsVC, animated: true)
    }
}
