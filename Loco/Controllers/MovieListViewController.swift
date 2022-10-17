//
//  MovieListViewController.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import UIKit

class MovieListViewController: BaseViewController {
    
    
    // MARK: - Outlets
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var searchButton: UIButton!
    @IBOutlet private var tableView: UITableView!
    
    
    // MARK: - Variables
    private var movieCellViewModel: MovieCellViewModel? {
        didSet {
            
            // Fetch Data To Display In Table View
            movieCellViewModel?.closure = { [weak self] (response, error) in
                
                DispatchQueue.main.async {
                    
                    // Reload Table View
                    self?.tableView.reloadData()
                    
                    // Hide Loader
                    self?.hideLoader()
                }
            }
        }
    }
    
    private var searchText = String() {
        didSet {
            
            // Disable Search Button If Search Text Is Empty
            searchButton.isEnabled = !searchText.isEmpty
        }
    }
    
    
    // MARK: - Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Complete Initial Setup
        initialSetup()
    }
    
    
    // MARK: - Helper Methods
    private func initialSetup() {
        
        // Set Navigation Title
        title = "Movies"
        
        // Setup Search Bar
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        
        // Disable Search Button Initially
        searchButton.isEnabled = false
        
        // Setup TableView
        tableView.register(MovieCell.nib(), forCellReuseIdentifier: MovieCell.identifier())
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK: - Button Click Events
    @IBAction func searchButtonTapped(_ sender: Any) {
        
        // Show Loader
        showLoader()
        
        // Create View Model For New Query
        movieCellViewModel = MovieCellViewModel(searchText)
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCellViewModel?.numberOrRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Validations
        guard let movieCellViewModel = movieCellViewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier(), for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        
        // Get Movie
        let movie = movieCellViewModel.getMovie(index: indexPath.row)
        
        // Set Movie Detials For Cell
        cell.setMovieData(movie: movie)
        
        // Return Cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Selected Movie
        guard let movie = movieCellViewModel?.getMovie(index: indexPath.row) else { return }
        
        // Push Detail View Controller
        self.navigationController?.pushViewController(MovieDetailsViewController(movie: movie), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let totalRows = movieCellViewModel?.numberOrRows(),
           indexPath.row == totalRows - 3 {
            
            // Fetch Next Page
            movieCellViewModel?.callApiService(shouldFetchNextPage: true)
        }
    }
}


// MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
}
