//
//  PokemonInfo.swift
//  PokeDex
//
//  Created by Chung Han Hsin on 2024/4/25.
//

import Foundation

struct PokemonInfo {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    var imageData: Data?
    
    init(with dto: PokemonInfoDTO) {
        id = dto.id
        name = dto.name
        height = dto.height
        weight = dto.weight
    }
}
