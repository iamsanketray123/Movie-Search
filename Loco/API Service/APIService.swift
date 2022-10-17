//
//  APIService.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import Foundation

struct APIService {
    
    /// This method can be used to call any GET api as long as the object returned confirms to the Decodable protocol
    /// - Parameters:
    ///   - requestUrl: URL endpoint to fetch data from
    ///   - resultType: This will be the type of object we expect after JSON parsing
    ///   - completionHandler: Callback with Result & Error
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
    
    /// This method can be called to download any kind of data
    /// - Parameters:
    ///   - url: URL endpoint to fetch data from
    ///   - completionHandler: Callback with result from API call
    public static func downloadData(url: URL, completionHandler: @escaping (Result<Data>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                
                // Call Completion Block
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            // Call Completion Block
            completionHandler(.success(data))
            
        }.resume()
    }
    
    // Result enum is a generic for any type of value with success and failure case
    public enum Result<T> {
        case success(T)
        case failure(Error)
    }
}

