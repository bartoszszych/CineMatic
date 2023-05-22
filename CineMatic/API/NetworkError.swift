//
//  NetworkError.swift
//  CineMatic
//
//  Created by Bartosz Szych on 22/05/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case noData
    case decodingError
    case statusCode(Int)
}
