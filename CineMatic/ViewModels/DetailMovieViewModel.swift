//
//  ViewMovieControllerViewModel.swift
//  CineMatic
//
//  Created by Bartosz Szych on 22/05/2023.
//

import Foundation
import UIKit

class DetailMovieViewModel {
    
    // MARK: - Variables
    let movie: Movie
    
    
    // MARK: - Initializer
    init(_ movie: Movie) {
        self.movie = movie
    }
    
    
    // MARK: - Computed Properties
    var voteAverageLabel: String {
        return "Score: \(self.movie.voteAverage)"
    }
    
    var voteCountLabel: String {
        return "Votes: \(self.movie.voteCount)"
    }
    
    var overviewLabel: String {
        return "\(self.movie.overview)"
    }
}
