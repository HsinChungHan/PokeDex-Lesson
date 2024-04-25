//
//  ViewController.swift
//  PokeDex
//
//  Created by Chung Han Hsin on 2024/4/17.
//

import UIKit

class ViewController: UIViewController {
    let allPokemonListViewController = AllPokemonListViewController.init()
    let allPokemonListViewModel = AllPokemonListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        allPokemonListViewModel.delegate = self
//        allPokemonListViewModel.loadAllPokemonList()
        
        view.addSubview(allPokemonListViewController.view)
        allPokemonListViewController.view.fillWithPadding()
    }


}

extension ViewController: AllPokemonListViewModelDelegate {
    func allPokemonListViewModel(_ allPokemonListViewModel: AllPokemonListViewModel, allPokemonListDidUpdate allPokemonList: AllPokemonList) {
        print(allPokemonList)
    }
    
    func allPokemonListViewModel(_ allPokemonListViewModel: AllPokemonListViewModel, allPokemonListErrorDidUpdate error: AllPokemonListServiceError) {
        print(error)
    }
}
