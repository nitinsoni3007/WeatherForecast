//
//  CityCell.swift
//  WetherForecast
//
//  Created by Nitin Soni on 19/08/21.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    weak var viewModel: HomeViewModel?
    var cityName: String?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with cityName: String) {
        self.cityName = cityName
        cityNameLabel.text = cityName
    }
    
    @IBAction func removeCityAction(_ sender: Any) {
        if let cityName = self.cityName {
            viewModel?.removeCity(cityName: cityName)
        }
    }
}
