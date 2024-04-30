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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pokemonListTableView)
        title = "Pokemon List"
        pokemonListTableView.backgroundColor = .red
        pokemonListTableView.fillWithPadding()
        viewModel.delegate = self
        // Step1: Use viewmodel load pokemon list
        viewModel.loadAllPokemonList()
    }
}


extension AllPokemonListViewController: AllPokemonListViewModelDelegate {
    func allPokemonListViewModel(_ allPokemonListViewModel: AllPokemonListViewModel, allPokemonListDidUpdate allPokemonList: AllPokemonList) {
        // Step3: Reload TableView
        pokemonListTableView.reloadData()
        viewModel.isLoadingAndPresentingNewPokemonList = false
    }
    
    func allPokemonListViewModel(_ allPokemonListViewModel: AllPokemonListViewModel, allPokemonListErrorDidUpdate error: AllPokemonListServiceError) {
        viewModel.isLoadingAndPresentingNewPokemonList = false
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
        return viewModel.allPokemonListCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Step4: Configure cell
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AllPokemonListCell.self), for: indexPath) as! AllPokemonListCell
        let cellModel = viewModel.allPokemonListCellModels[indexPath.row]
        cell.configureCell(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    // 滑到底了
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 取得當前 tableView 的最後一個 section 的最後一個 row(tableView 的最底下的 row)
        let lastSectionIndex =  tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        // 判斷最後一個 cell 是否有要被顯示
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            viewModel.loadAllPokemonList()
        }
    }
}

extension AllPokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setupPokemonNameForInfoPage(with: indexPath)
        let pokemonInfoViewController = PokemonInfoPageViewController()
        pokemonInfoViewController.dataSource = self
        navigationController?.pushViewController(pokemonInfoViewController, animated: true)
//        present(pokemonInfoViewController, animated: true)
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



