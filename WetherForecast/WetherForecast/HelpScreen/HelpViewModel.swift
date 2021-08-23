//
//  HelpViewModel.swift
//  WetherForecast
//
//  Created by Nitin Soni on 21/08/21.
//

import Foundation

class HelpViewModel {
    func getHelpScreenRequestToLoad(_ completion: ((URLRequest?) -> Void)) {
        guard let filePath = Bundle.main.path(forResource: "HelpScreen1", ofType: "html") else {return}
        let urlRequest = URLRequest(url: URL(fileURLWithPath: filePath))
        completion(urlRequest)
    }
}
