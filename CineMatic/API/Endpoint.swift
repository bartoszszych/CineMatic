//
//  Endpoint.swift
//  CineMatic
//
//  Created by Bartosz Szych on 22/05/2023.
//

import Foundation

enum Endpoint {
    
    case fetchMovies(url: String = "/3/movie/top_rated", page: Int = 1)
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)
        print("DEBUG PRINT: Request url - \(request)")
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchMovies(let url, _):
            return url
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .fetchMovies(_, let page):
            return [
                URLQueryItem(name: "api_key", value: Constants.API_KEY),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: page.description),
            ]
        }
    }
    
    private var httpMethod: String {
        
        switch self {
        case .fetchMovies:
            return HTTP.Method.get.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchMovies:
            return nil
        }
    }
}

extension URLRequest {
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .fetchMovies:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
        }
    }
}
