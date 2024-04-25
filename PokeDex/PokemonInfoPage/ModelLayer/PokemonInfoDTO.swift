//
//  PokemonInfoDTO.swift
//  PokeDex
//
//  Created by Chung Han Hsin on 2024/4/17.
//

import Foundation

struct PokemonInfoDTO: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
}
