//
//  AllPokemonListHTTPClient.swift
//  PokeDex
//
//  Created by Chung Han Hsin on 2024/4/17.
//

import Foundation

class AllPokemonListHTTPClient: HTTPClient {
    fileprivate var offset: Int = 0
    
    let limit: Int
    init(limit: Int = 30) {
        self.limit = limit
    }
    
    func reuestAllPokemonList(completion: @escaping (Result<(Data, HTTPURLResponse), HTTPClientError>) -> Void) {
        request(with: allPokemonListRequestType, completion: completion)
    }
    
    func updateOffset() {
        offset += limit
    }
}


extension AllPokemonListHTTPClient {
    // https://pokeapi.co/api/v2/pokemon?limit=1302
    var allPokemonListRequestType: RequestType {
        return RequestType.init(httpMethod: .GET, domainURL: .init(string: "https://pokeapi.co/api/v2")!, path: "/pokemon", queryItems: [
            .init(name: "limit", value: "\(limit)"),
            .init(name: "offset", value: "\(offset)")
        ])
    }
}
