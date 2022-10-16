//
//  ViewController.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    
    // MARK: - Variables
    private var movieCellViewModel = MovieCellViewModel()
    let searchController = UISearchController()
    let tableView = UITableView()
    
    
    // MARK: - Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Complete Initial Setup
        initialSetup()
        
        // Fetch Data To Display In Table View
        movieCellViewModel.closure = { response in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Helper Methods
    private func initialSetup() {
        
        // Set Navigation Title
        title = "Movies"
        
        // Setup Navigation Controller
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .clear
        navigationItem.searchController = searchController
        
        // Setup Search Controller
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.searchBarStyle = .prominent
        
        // Setup TableView
        tableView.register(MovieCell.nib(), forCellReuseIdentifier: MovieCell.identifier())
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        // Add Table View Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCellViewModel.numberOrRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier(), for: indexPath) as? MovieCell else {
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
        let movie = movieCellViewModel.getMovie(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
