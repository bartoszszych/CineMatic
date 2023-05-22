//
//  ViewMovieController.swift
//  CineMatic
//
//  Created by Bartosz Szych on 22/05/2023.
//

import UIKit

class ViewMovieController: UIViewController {
    
    // MARK: - Variables
    let viewModel: DetailMovieViewModel
    
    private let viewMovieView = DetailMovieView()
    
    // MARK: - LifeCycle
    init(_ viewModel: DetailMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(viewMovieView)
        self.viewMovieView.viewModel = self.viewModel
        self.viewMovieView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.viewMovieView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.viewMovieView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.viewMovieView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.viewMovieView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = self.viewModel.movie.title
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        
    }
}
