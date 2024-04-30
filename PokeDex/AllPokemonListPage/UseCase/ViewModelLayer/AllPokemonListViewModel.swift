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
    var allPokemonListCellModels = [AllPokemonListCellModel]()
    var pokemonNameForInfoPage: String?
    let service = AllPokemonListService()
    // flag
    var isLoadingAndPresentingNewPokemonList = false
}

// MARK: - Internal Methods and Network Service
extension AllPokemonListViewModel {
    func loadAllPokemonList() {
        if isLoadingAndPresentingNewPokemonList {
            // 代表現在正在 loading data
            return
        }
        isLoadingAndPresentingNewPokemonList = true
        service.loadAllPokemonList { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(allPokemonList):
                for name in allPokemonList.pokemonNames {
                    self.allPokemonListCellModels.append(AllPokemonListCellModel.init(name: name))
                }
                self.delegate?.allPokemonListViewModel(self, allPokemonListDidUpdate: allPokemonList)
            case let .failure(error):
                self.delegate?.allPokemonListViewModel(self, allPokemonListErrorDidUpdate: error)
            }
        }
    }
    
    func setupPokemonNameForInfoPage(with indexPath: IndexPath) {
        let name = allPokemonListCellModels[indexPath.row].name
        pokemonNameForInfoPage = name
    }
}



