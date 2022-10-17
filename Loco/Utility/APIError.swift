//
//  APIError.swift
//  Loco
//
//  Created by Sanket  Ray on 17/10/22.
//

import Foundation

public enum APIError: Error {
    case urlFailed
    case noData
    case requestError
    case parsingFailed
    
    var description : String {
        switch self {
            case .urlFailed: return "Unable to fetch results from server. Please retry after some time."
            case .noData, .requestError, .parsingFailed: return "Failed to get results. Please try a different movie name."
        }
    }
}
