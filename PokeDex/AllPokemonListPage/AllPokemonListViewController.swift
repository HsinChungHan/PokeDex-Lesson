//
//  AllPokemonListViewController.swift
//  PokedexDemo
//
//  Created by 黃昭銘 on 2024/4/18.
//

import Foundation
import UIKit

class AllPokemonListViewController: UIViewController {
    // MARK: - stored properties
    let viewModel = AllPokemonListViewModel()
    lazy var pokemonListTableView = makeTableView()
    
    // TODO: - Should be removed
    let pokemonInfoHTTPClient = PokemonInfoHTTPClient()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pokemonListTableView)
        pokemonListTableView.backgroundColor = .red
        pokemonListTableView.fillWithPadding()
        viewModel.delegate = self
        // Step1: Use viewmodel load pokemon list
        viewModel.loadAllPokemonList()
        
        // TODO: - Should be removed
        pokemonInfoHTTPClient.requestPokemonImage(with: "1") { result in
            switch result {
            case let .success(data):
                print(data)
            case .failure(_):
                return
            }
        }
    }
}

extension AllPokemonListViewController: AllPokemonListViewModelDelegate {
    func allPokemonListViewModel(_ allPokemonListViewModel: AllPokemonListViewModel, allPokemonListDidUpdate allPokemonList: AllPokemonList) {
        // Step3: Reload TableView
        pokemonListTableView.reloadData()
    }
    
    func allPokemonListViewModel(_ allPokemonListViewModel: AllPokemonListViewModel, allPokemonListErrorDidUpdate error: AllPokemonListServiceError) {
        
    }
}

extension AllPokemonListViewController {
    func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AllPokemonListCell.self, forCellReuseIdentifier: String(describing: AllPokemonListCell.self))
        return tableView
    }
}

extension AllPokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Step3: Renew the number of rows
        return viewModel.allPokemonNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Step4: Configure cell
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AllPokemonListCell.self), for: indexPath) as! AllPokemonListCell
        let cellModel = viewModel.makeCellModel(with: indexPath)
        cell.configureCell(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension AllPokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setupPokemonNameForInfoPage(with: indexPath)
        let pokemonInfoViewController = PokemonInfoPageViewController()
        pokemonInfoViewController.dataSource = self
        present(pokemonInfoViewController, animated: true)
    }
}

extension AllPokemonListViewController: PokemonInfoPageViewControllerDataSource {
    var pokemonName: String {
        guard let name = viewModel.pokemonNameForInfoPage else {
            fatalError("PokemonNameForInfoPage should not be nil!")
        }
        return name
    }
}



