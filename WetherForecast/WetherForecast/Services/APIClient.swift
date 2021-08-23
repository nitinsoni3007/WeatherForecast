//
//  APIClient.swift
//  WetherForecast
//
//  Created by Nitin Soni on 20/08/21.
//

import Foundation

struct APIError: Codable, Error {
    var title: String?
    var message: String?
    var description: String?
    var statusCode: Int? = 0
}

class APIClient {
    static let shared = APIClient()
    private init() {}
    
    public func get<S, F>(urlString: String, headers: [String: String]? = nil, queryParams: [String: Any]? = nil, success: S.Type, failure: F.Type, _ completion: @escaping (Result<S, APIError>) -> Void) where S:Decodable, F:Decodable {

        let session = URLSession(configuration: .default)
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        if let queryParams = queryParams {

            if var urlComponents = URLComponents(string: url.absoluteString) {

                urlComponents.queryItems = [URLQueryItem]()

                for queryItem in queryParams {

                    let queryItem = URLQueryItem(name: queryItem.key, value: String(describing: queryItem.value))
                    urlComponents.queryItems?.append(queryItem)
                }
                request.url = urlComponents.url
            }
        }

        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        let task = session.dataTask(with: request) { data, response, error in
            if let _ = error, let resultData = data {
                do {
                    let err = try JSONDecoder().decode(APIError.self, from: resultData)
                completion(.failure(err))
                } catch {
                    let err = APIError(title: nil, message: "Something went wrong", description: nil, statusCode: 0)
                    completion(.failure(err))
                }
            } else {
                if let _ = response, let respData = data, !respData.isEmpty {
                    do {
                        let accessTokenResp = try JSONDecoder().decode(S.self, from: respData)
                        completion(.success(accessTokenResp))
                    } catch {
                        let err = APIError(title: nil, message: "Unable to parse response data", description: nil, statusCode: 0)
                        completion(.failure(err))
                    }
                }
            }
        }
        task.resume()
    }
}
