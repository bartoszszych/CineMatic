//
//  MovieCell.swift
//  CineMatic
//
//  Created by Bartosz Szych on 21/05/2023.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    
    // MARK: - Variables
    private(set) var movie: Movie!
    
    // MARK: - UI Components
    
    private let moviePoster: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .black
        return iv
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Error"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with movie: Movie) {
        self.movie = movie
        
        self.movieTitle.text = movie.title
        
        self.moviePoster.sd_setImage(with: movie.posterURL)
    }
    
    // TODO: - Prepare for reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieTitle.text = nil
        self.moviePoster.image = nil
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(moviePoster)
        self.addSubview(movieTitle)
        
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moviePoster.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            moviePoster.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            moviePoster.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            moviePoster.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 16),
            movieTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}
