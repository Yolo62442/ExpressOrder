//
//  NetworkManager.swift
//  ExpressOrder
//
//  Created by ra on 2/27/22.
//

import Foundation

class NetworkManager: NSObject {
    let scheme = "https"
    let host = "142.93.107.238"
    var path: ApiPath = .restaurants
    var method: HTTPMethod = .get
    var headers: [String: String]?
    var queryItems: [String: String]?
    var bodyParameters: [String: Any]?
    
    private var session: URLSession = .init(configuration: .default)
    
    public override init() {
        super.init()
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }
    
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path.stringPath
        if let queryItems = queryItems {
            components.queryItems = queryItems.map{ URLQueryItem(name: $0.0, value: $0.1) }
        }
        return components
    }
    
    private var urlRequest: URLRequest {
        let url = urlComponents.url!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let body = bodyParameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        headers?.forEach { urlRequest.setValue($0.1, forHTTPHeaderField: $0.0) }
        return urlRequest
    }
    
    func fetchRestaurants(completion: @escaping ((RestaurantResult) -> Void)) {
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error { return completion(.failure(error)) }
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else { return completion(.failure(NSError())) }
            guard let data = data else { return completion(.failure(NSError())) }
            do {
                let restaurant = try JSONDecoder().decode([Restaurant].self, from: data)
                completion(.success(restaurant.map{ $0.restaurant }))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func makeRequest<T: Codable>(completion: @escaping ((Result<T>) -> Void)) {
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error { return completion(.failure(error)) }
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else { return completion(.failure(NSError())) }
            guard let data = data else { return completion(.failure(NSError())) }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

extension NetworkManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, urlCredential)
    }
}
