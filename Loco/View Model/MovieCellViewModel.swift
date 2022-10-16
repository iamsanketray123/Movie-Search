//
//  MovieCellViewModel.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import Foundation

class MovieCellViewModel {
    
    
    // MARK: - Variables
    public var closure: ((MovieResponse?) -> Void)?
    private var movies = [Movie]()
    
    
    // MARK: - Lifecycle Methods
    init(_ searchQuery: String) {
        
        // Make API Call For Query
        callApiService(for: searchQuery)
    }
    
    private func callApiService(for searchQuery: String) {
        
        // Create URL
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(searchQuery)&apikey=17c5b420") else { return }
        
        // Get Data From API Service
        APIService.getData(requestUrl: url, resultType: MovieResponse.self) { [weak self] response in
            
            // Validation
            guard let self = self else { return }
            
            self.movies = response.movies
            self.handleResponse(response: response)
        }
    }
    
    private func handleResponse(response: MovieResponse) {
        closure?(response)
    }

    func numberOrRows() -> Int {
        return movies.count
    }

    func getMovie(index: Int) -> Movie {
        return movies[index]
    }
}
