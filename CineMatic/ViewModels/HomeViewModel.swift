//
//  HomeControllerViewModel.swift
//  CineMatic
//
//  Created by Bartosz Szych on 22/05/2023.
//

import Foundation
import UIKit

class HomeViewModel {
    var onMoviesUpdated: (()->Void)?

    private(set) var allMovies: [Movie] = [] {
        didSet {
            self.onMoviesUpdated?()
        }
    }
    
    private(set) var filteredMovies: [Movie] = [] {
        didSet {
        }
    }
    
    init() {
        self.fetchMovies()
    }
    
    public func fetchMovies(for page: Int = 1) {
        let endpoint = Endpoint.fetchMovies(page: page)
        MovieService.fetchMovies(with: endpoint) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.allMovies.append(contentsOf: movies)
                print("DEBUG PRINT: ", "\(movies.count) movies fetched")

            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Search Functions
extension HomeViewModel {
    
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        self.filteredMovies = allMovies
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { self.onMoviesUpdated?(); return}
            
            self.filteredMovies = self.filteredMovies.filter({ $0.title.lowercased().contains(searchText)})
        }
        
        self.onMoviesUpdated?()
    }
}

