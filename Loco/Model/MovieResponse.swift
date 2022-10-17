//
//  MovieResponse.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import Foundation


// MARK: - MovieResponse
struct MovieResponse: Decodable {
    let movies: [Movie]
    let totalResults: String
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
    }
}


// MARK: - Movie
struct Movie: Decodable {
    let title, year, imdbId: String
    let posterImageUrlString: String
    var details: Details?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case posterImageUrlString = "Poster"
    }
    
    struct Details: Decodable {
        let released: String
        let plot: String
        let director: String
        let imdbRating: String
        
        enum CodingKeys: String, CodingKey {
            case released = "Released"
            case plot = "Plot"
            case director = "Director"
            case imdbRating
        }
    }
}
