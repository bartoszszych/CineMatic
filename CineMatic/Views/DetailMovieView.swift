//
//  ViewMovieView.swift
//  CineMatic
//
//  Created by Bartosz Szych on 22/05/2023.
//

import UIKit
import SDWebImage

class DetailMovieView: UIView {
    
    // MARK: - Variables
    var viewModel: DetailMovieViewModel? {
        didSet {
            self.configureView()
        }
    }
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let moviePoster: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.tintColor = .lightGray
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.text = "Movie Title"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.text = "8.5"
        return label
    }()
    
    private let voteAverageIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "star.fill")
        iv.tintColor = .systemYellow
        return iv
    }()
    
    private let voteCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "1283 votes"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Overview text goes here. Overview text goes here. Overview text goes here. Overview text goes here."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(moviePoster)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(voteAverageLabel)
        self.contentView.addSubview(voteAverageIcon)
        self.contentView.addSubview(voteCountLabel)
        self.contentView.addSubview(overviewLabel)
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.moviePoster.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.voteAverageIcon.translatesAutoresizingMaskIntoConstraints = false
        self.voteCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            self.moviePoster.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.moviePoster.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.moviePoster.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.moviePoster.heightAnchor.constraint(equalToConstant: 400),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.moviePoster.bottomAnchor, constant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            
            self.voteAverageLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.voteAverageLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            
            self.voteAverageIcon.centerYAnchor.constraint(equalTo: self.voteAverageLabel.centerYAnchor),
            self.voteAverageIcon.leadingAnchor.constraint(equalTo: self.voteAverageLabel.trailingAnchor, constant: 10),
            self.voteAverageIcon.widthAnchor.constraint(equalToConstant: 24),
            self.voteAverageIcon.heightAnchor.constraint(equalToConstant: 24),
            
            self.voteCountLabel.topAnchor.constraint(equalTo: self.voteAverageLabel.bottomAnchor, constant: 10),
            self.voteCountLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            
            self.overviewLabel.topAnchor.constraint(equalTo: self.voteCountLabel.bottomAnchor, constant: 20),
            self.overviewLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.overviewLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.overviewLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Helper Methods
    private func configureView() {
        guard let viewModel = viewModel else { return }
        
        self.titleLabel.text = viewModel.movie.title
        self.voteAverageLabel.text = viewModel.voteAverageLabel
        self.voteCountLabel.text = viewModel.voteCountLabel
        self.overviewLabel.text = viewModel.overviewLabel
        self.moviePoster.sd_setImage(with: viewModel.movie.posterURL)
    }
}
