//
//  APIService.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import Foundation

struct APIService {
    
    public static func getData<T: Decodable>(requestUrl: URL, resultType: T.Type, completionHandler: @escaping(_ result: T?, _ error: Error?) -> Void) {
        
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            
            // Validations
            if error == nil,
               responseData != nil,
               responseData?.count != 0 {
                
                // Parse Response
                do {
                    let result = try JSONDecoder().decode(resultType, from: responseData!)
                    completionHandler(result, nil)
                }
                catch let error {
                    completionHandler(nil, error)
                }
            }
        }.resume()
    }
    
    public static func downloadImage(url: URL, completion: @escaping (Result<Data>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                
                // Call Completion Block
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            // Call Completion Block
            completion(.success(data))
            
        }.resume()
    }
    
    // Result enum is a generic for any type of value
    // with success and failure case
    public enum Result<T> {
        case success(T)
        case failure(Error)
    }
}

