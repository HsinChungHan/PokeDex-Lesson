//
//  AllPokemonListViewModel.swift
//  PokeDex
//
//  Created by Chung Han Hsin on 2024/4/17.
//

import Foundation

protocol AllPokemonListViewModelDelegate: AnyObject {
    func allPokemonListViewModel(_ allPokemonListViewModel: AllPokemonListViewModel, allPokemonListDidUpdate allPokemonList: AllPokemonList)
    func allPokemonListViewModel(_ allPokemonListViewModel: AllPokemonListViewModel, allPokemonListErrorDidUpdate error: AllPokemonListServiceError)
}

class AllPokemonListViewModel {
    weak var delegate: AllPokemonListViewModelDelegate?
    var allPokemonNames = [String]()
    var pokemonNameForInfoPage: String?
    let service = AllPokemonListService()
}

// MARK: - Internal Methods and Network Service
extension AllPokemonListViewModel {
    func loadAllPokemonList() {
        service.loadAllPokemonList { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(allPokemonList):
                self.allPokemonNames = allPokemonList.pokemonNames
                self.delegate?.allPokemonListViewModel(self, allPokemonListDidUpdate: allPokemonList)
            case let .failure(error):
                self.delegate?.allPokemonListViewModel(self, allPokemonListErrorDidUpdate: error)
            }
        }
    }
    
    func makeCellModel(with indexPath: IndexPath) -> AllPokemonListCellModel {
        let name = allPokemonNames[indexPath.row]
        return .init(name: name)
    }
    
    func setupPokemonNameForInfoPage(with indexPath: IndexPath) {
        let name = allPokemonNames[indexPath.row]
        pokemonNameForInfoPage = name
    }
}



