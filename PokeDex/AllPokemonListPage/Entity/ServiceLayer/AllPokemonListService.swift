//
//  AllPokemonListService.swift
//  PokeDex
//
//  Created by Chung Han Hsin on 2024/4/17.
//

import Foundation

enum AllPokemonListServiceError: Error {
    case JSONParsingError
    case NetworkError
}

class AllPokemonListService {
    let client = AllPokemonListHTTPClient()
    func loadAllPokemonList(completion: @escaping (Result<AllPokemonList, AllPokemonListServiceError>) -> Void) {
        client.reuestAllPokemonList { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success((data, reponse)): // tuple (Data, HTTPURLResponse) -> type
                    // do success behavior
                    do {
                        let allPokemonListDTO = try JSONDecoder().decode(AllPokemonListDTO.self, from: data)
                        let allPokemonList = AllPokemonList(from: allPokemonListDTO)
                        completion(.success(allPokemonList))
                        self.client.updateOffset()
                    } catch {
                        completion(.failure(.JSONParsingError))
                    }
                case .failure:
                    // do failure behavior
                    completion(.failure(.NetworkError))
                }
            }
        }
    }
}
