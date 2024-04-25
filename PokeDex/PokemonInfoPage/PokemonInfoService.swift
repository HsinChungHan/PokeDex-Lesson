//
//  PokemonInfoService.swift
//  PokeDex
//
//  Created by Chung Han Hsin on 2024/4/25.
//

import Foundation

enum PokemonInfoServiceError: Error {
    case JSONParsingError
    case ImageDataError
    case NetworkError
}

class PokemonInfoService {
    let client = PokemonInfoHTTPClient()
    func loadPokemonInfo(with name: String, completion: @escaping (Result<PokemonInfo, PokemonInfoServiceError>) -> Void) {
        client.requestPokemonInfo(with: name) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success((data, _)):
                    do {
                        let pokemonInfoDTO = try JSONDecoder().decode(PokemonInfoDTO.self, from: data)
                        let pokemonInfo = PokemonInfo(from: pokemonInfoDTO)
                        completion(.success(pokemonInfo))
                    } catch {
                        completion(.failure(.JSONParsingError))
                    }
                case .failure(_):
                    completion(.failure(.NetworkError))
                }
            }
        }
    }
    
    func loadPokemonImage(with id: String, completion: @escaping (Result<Data, PokemonInfoServiceError>) -> Void) {
        client.requestPokemonImage(with: id) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success((imageData, _)):
                    completion(.success(imageData))
                case .failure(_):
                    completion(.failure(.NetworkError))
                }
            }
        }
    }
    
    func loadPokemonInfoAndImage(with name: String, completion: @escaping (Result<PokemonInfo, PokemonInfoServiceError>) -> Void) {
        self.loadPokemonInfo(with: name) { [weak self]  result in
            guard let self else { return }
            switch result {
            case var .success(pokemonInfo):
                // 成功拿到 pokemonInfo -> ID
                // loadPokemonImage
                let id = "\(pokemonInfo.id)"
                self.loadPokemonImage(with: id) { result in
                    switch result {
                    case let .success(imageData):
                        // 將 imageData 存進 pokemonInfo
                        pokemonInfo.imageData = imageData
                        completion(.success(pokemonInfo))
                    case .failure(_):
                        completion(.failure(.ImageDataError))
                    }
                }
            case .failure(_):
                completion(.failure(.NetworkError))
            }
        }
    }
}
