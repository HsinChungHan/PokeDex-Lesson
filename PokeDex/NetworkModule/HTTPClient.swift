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
    
    func request(with requestType: RequestType, completion: @escaping (Data?, HTTPURLResponse?, HTTPClientError?) -> Void) {
        urlSession.dataTask(with: requestType.getURLRequest()) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                completion(nil, nil, .NetworkError)
                return
            }
            
            guard
                let response = response as? HTTPURLResponse,
                let data = data
            else {
                completion(nil, nil, .ResponseAndDataNilError)
                return
            }
            completion(data, response, nil)
        }.resume()
    }
}
