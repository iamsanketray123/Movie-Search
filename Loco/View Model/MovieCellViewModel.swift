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
    private var totalResults = Int()
    private var page = 1
    
    // MARK: - Lifecycle Methods
    init(_ searchQuery: String) {
        
        // Make API Call For Query
        callApiService(for: searchQuery)
    }
    
    public func callApiService(for searchQuery: String, shouldFetchNextPage: Bool = false) {
        
        // Already Have Max Results
        if totalResults > 0, movies.count == totalResults { return }
        
        if shouldFetchNextPage { page += 1 }
        
        // Create URL
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(searchQuery)&apikey=17c5b420&page=\(page)") else { return }
        
        // Get Data From API Service
        APIService.getData(requestUrl: url, resultType: MovieResponse.self) { [weak self] response in
            
            // Validation
            guard let self = self else { return }
            
            self.totalResults = Int(response.totalResults) ?? 0
            self.movies.append(contentsOf: response.movies)
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
