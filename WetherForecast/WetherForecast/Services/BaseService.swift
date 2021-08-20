//
//  BaseService.swift
//  WetherForecast
//
//  Created by Nitin Soni on 20/08/21.
//

import Foundation


protocol BaseServiceProtocol {
    func get<S, F>(urlString: String, headers: [String: String]?, queryParams: [String: Any]?, success: S.Type, failure: F.Type, _ completion: @escaping (Result<S, APIError>) -> Void) where S:Decodable, F:Decodable
}

class BaseService: BaseServiceProtocol {
    func get<S, F>(urlString: String, headers: [String: String]? = nil, queryParams: [String: Any]? = nil, success: S.Type, failure: F.Type, _ completion: @escaping (Result<S, APIError>) -> Void) where S:Decodable, F:Decodable {
        APIClient.shared.get(urlString: urlString, headers: nil, queryParams: queryParams, success: success, failure: failure, completion)
    }
}
