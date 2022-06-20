//
//  ApiManager.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import Foundation

typealias APICompletion = (APIResult) -> Void

enum APIResult {
    case success(JSObject?)
    case failure(APIError)
}

enum APIError: Error {
    case error(String)
    case errorURL

    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
        case .errorURL:
            return "URL String is error."
        }
    }
}

enum Method: String {
    case get
    case post
    case put
    case delete
}

final class ApiManager {

    static let shared: ApiManager = ApiManager()

    var defaultHTTPHeaders: [String: String] = {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json;charset=UTF-8"
        return headers
    }()

    func request(method: Method,
                 headers: [String: String] = [:],
                 parameters: [String: Any] = [:],
                 with path: String,
                 completion: @escaping APICompletion) {
        // Check Interneet is available
        if !Reachability.isInternetAvailable() {
            #warning("Handle show pop up announce internet is not available")
            return
        }

        // Check url is existed
        guard let url = URL(string: path) else {
            completion(.failure(.errorURL))
            return
        }

        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Add Header
        if !headers.isEmpty {
            headers.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        // Add Parameter
        if parameters.isEmpty {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                completion(.failure(.error(error.localizedDescription)))
            }
        }

        // config
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true

        // session
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.error(error.localizedDescription)))
                } else {
                    completion(.success(data?.toJSON()))
                }
            }
        }

        task.resume()
    }
}
