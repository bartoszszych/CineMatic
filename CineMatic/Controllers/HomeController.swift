//
//  ViewController.swift
//  CineMatic
//
//  Created by Bartosz Szych on 21/05/2023.
//

import UIKit

class HomeController: UIViewController {
    // MARK: - Variables
    private let viewModel: HomeViewModel
    private var currentPage = 1
    public var isLoadingData = false

    // MARK: - UI Components
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        return tv
    }()
    
    // MARK: - LifeCycle
    init(_ viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupSearchController()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel.onMoviesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.isLoadingData = false
            }
            
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "CineMatic"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
            
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search movies"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }

}

// MARK: - Search Controller functions
extension HomeController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
}

// MARK: - TableView Functions
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        return inSearchMode ? self.viewModel.filteredMovies.count : self.viewModel.allMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            fatalError("Unable to dequeue MovieCell in HomeController")
        }
        
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        let movie = inSearchMode ? self.viewModel.filteredMovies[indexPath.row] :
        self.viewModel.allMovies[indexPath.row]
        cell.configure(with: movie)
        cell.updateConstraintsIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        let movie = inSearchMode ? self.viewModel.filteredMovies[indexPath.row] :
        self.viewModel.allMovies[indexPath.row]
        let vm = DetailMovieViewModel(movie)
        let vc = ViewMovieController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let inSearchMode = viewModel.inSearchMode(searchController)
        let moviesCount = inSearchMode ? viewModel.filteredMovies.count : viewModel.allMovies.count
        
        if indexPath.row == moviesCount - 1 && !isLoadingData && !viewModel.inSearchMode(searchController) {
            currentPage += 1
            self.viewModel.fetchMovies(for: currentPage)
            isLoadingData = true
        }
    }
}
