//
//  MovieCellViewModel.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import Foundation

class MovieCellViewModel {
    
    
    // MARK: - Variables
    public var closure: ((MovieResponse?, Error?) -> Void)?
    private var movies = [Movie]()
    private var totalResults = Int()
    private var page = 1
    public private(set) var searchQuery = String()
    
    
    // MARK: - Lifecycle Methods
    init(_ searchQuery: String) {
        
        // Save Search Query
        self.searchQuery = searchQuery
        
        // Make API Call For Query
        callApiService(for: searchQuery)
    }
    
    
    // MARK: - Helper Methods
    public func callApiService(for searchQuery: String, shouldFetchNextPage: Bool = false) {
        
        // Already Have Max Results
        if totalResults > 0, movies.count == totalResults { return }
        
        if shouldFetchNextPage { page += 1 }
        
        // Create URL
        guard let query = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://www.omdbapi.com/?s=\(query))&apikey=17c5b420&page=\(page)") else { return }
        
        // Get Data From API Service
        APIService.getData(requestUrl: url, resultType: MovieResponse.self) { [weak self] (response, error) in
            
            // Validation
            guard let self = self else { return }
            
            if let response = response {
                
                self.totalResults = Int(response.totalResults) ?? 0
                self.movies.append(contentsOf: response.movies)
                self.handleResponse(response: response, error: nil)
            } else if let error = error {
                self.handleResponse(response: nil, error: error)
            }
        }
    }
    
    private func handleResponse(response: MovieResponse?, error: Error?) {
        closure?(response, error)
    }
    
    public func numberOrRows() -> Int {
        return movies.count
    }
    
    public func getMovie(index: Int) -> Movie {
        return movies[index]
    }
}
