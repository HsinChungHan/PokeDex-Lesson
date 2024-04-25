//
//  PokemonInfoHTTPClient.swift
//  PokeDex
//
//  Created by Chung Han Hsin on 2024/4/24.
//

import Foundation

class PokemonInfoHTTPClient: HTTPClient {
    func reuestPokemonImage(with id: String, completion: @escaping (Result<(Data, HTTPURLResponse), HTTPClientError>) -> Void) {
        let requestType = makePokemonImageRequest(with: id)
        request(with: requestType, completion: completion)
    }
}


/*
 https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/{id}.png
 這隻可以拿到 pokemon 的圖片，透過不同的 id
 var headers: [String : String] {
         [
             "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.183 Safari/537.36"
         ]
     }
 */
fileprivate extension PokemonInfoHTTPClient {
    var headers: [String : String] {
        [
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.183 Safari/537.36"
        ]
    }
    
    func makePokemonImageRequest(with id: String) -> RequestType {
        let url = URL.init(string: "https://raw.githubusercontent.com")!
        let path = "/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/\(id).png"
        return RequestType.init(httpMethod: .GET, domainURL: url, path: path, headers: headers)
    }
}
