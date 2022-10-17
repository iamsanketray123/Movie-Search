//
//  MovieCellViewModel.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import Foundation

class MovieCellViewModel {
    
    
    // MARK: - Variables
    public var closure: ((Result<MovieResponse>) -> Void)?
    private var movies = [Movie]()
    private var totalResults = Int()
    private var page = 1
    private var searchQuery = String()
    
    
    // MARK: - Lifecycle Methods
    init(_ searchQuery: String) {
        
        // Save Search Query
        self.searchQuery = searchQuery
        
        // Make API Call For Query
        callApiService()
    }
    
    
    // MARK: - Helper Methods
    /// The API call to fetch movies
    /// - Parameter shouldFetchNextPage: If this is passed in as `true` then we will be fetching the next page.
    public func callApiService(shouldFetchNextPage: Bool = false) {
        
        // Already Have Max Results
        if totalResults > 0, movies.count == totalResults { return }
        
        // Increment Page
        if shouldFetchNextPage { page += 1 }
        
        // Create URL
        guard let query = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://www.omdbapi.com/?s=\(query))&apikey=17c5b420&page=\(page)") else { return }
        
        // Get Data From API Service
        APIService.getData(requestUrl: url, resultType: MovieResponse.self) { [weak self] (result) in
            
            // Validation
            guard let self = self else { return }
            
            switch result {
                
            case .success(let response):
                self.totalResults = Int(response.totalResults) ?? 0
                self.movies.append(contentsOf: response.movies)
                self.closure?(.success(response))
                
            case .failure(let error):
                self.closure?(.failure(error))
            }
        }
    }
    
    public func numberOrRows() -> Int {
        return movies.count
    }
    
    public func getMovie(index: Int) -> Movie {
        return movies[index]
    }
}
