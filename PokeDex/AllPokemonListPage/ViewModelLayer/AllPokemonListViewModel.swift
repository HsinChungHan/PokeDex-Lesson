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
    weak var deleagte: AllPokemonListViewModelDelegate?
    let service = AllPokemonListService()
    func loadAllPokemonList() {
        service.loadAllPokemonList { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(allPokemonList):
                self.deleagte?.allPokemonListViewModel(self, allPokemonListDidUpdate: allPokemonList)
            case let .failure(error):
                self.deleagte?.allPokemonListViewModel(self, allPokemonListErrorDidUpdate: error)
            }
        }
    }
}
