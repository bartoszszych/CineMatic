//  This file contains the 'MovieService' Singleton class, which is responsible for fetching a list of movies from an API using URLSession.

import Foundation


class MovieService: MovieServicing {
    static func fetchMovies(with endpoint: Endpoint, completion: @escaping (Result<[Movie], Error>) -> Void) {
           guard let request = endpoint.request else { return }

           URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   completion(.failure(error))
                   return
               }

               guard let httpResponse = response as? HTTPURLResponse else {
                   completion(.failure(NetworkError.invalidResponse))
                   return
               }

               switch httpResponse.statusCode {
               case 200...299:
                   guard let data = data else {
                       completion(.failure(NetworkError.noData))
                       return
                   }

                   do {
                       let decoder = JSONDecoder()
                       let movies = try decoder.decode(Movies.self, from: data)
                       completion(.success(movies.results))
                   } catch {
                       completion(.failure(NetworkError.decodingError))
                   }
               default:
                   completion(.failure(NetworkError.statusCode(httpResponse.statusCode)))
               }
           }.resume()
    }
    
    
}

protocol MovieServicing {
    static func fetchMovies(with endpoint: Endpoint, completion: @escaping (Result<[Movie], Error>) -> Void)
}
