//
//  HTTPClient.swift
//  PokeDex
//
//  Created by Chung Han Hsin on 2024/4/17.
//

import Foundation
// Error handling
enum HTTPClientError: Error {
    case NetworkError
    case ResponseAndDataNilError
}

class HTTPClient {
    let urlSession = URLSession.shared
                                                                                
    func request(with requestType: RequestType, completion: @escaping (Result<(Data, HTTPURLResponse), HTTPClientError>) -> Void) {
        urlSession.dataTask(with: requestType.getURLRequest()) { data, response, error in
            if let _ = error {
                completion(Result.failure(.NetworkError))
                return
            }
            
            guard
                let response = response as? HTTPURLResponse,
                let data = data
            else {
                completion(Result.failure(.ResponseAndDataNilError))
                return
            }
            completion(Result.success((data, response)))
        }.resume()
    }
}
