//
//  AllPokemonListCell.swift
//  PokeDex
//
//  Created by Chung Han Hsin on 2024/4/24.
//

import UIKit

class AllPokemonListCell: UITableViewCell {
    lazy var nameLabel = makeNameLabel()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupLayout()
    }
}

fileprivate extension AllPokemonListCell {
    func setupLayout() {
        contentView.addSubview(nameLabel)
        nameLabel.constraint(top: contentView.snp.top, bottom: contentView.snp.bottom, left: contentView.snp.left)
    }
    
    func makeNameLabel() -> UILabel {
        let nameLabel = UILabel()
        return nameLabel
    }
}

internal extension AllPokemonListCell {
    func configureCell(with cellModel: AllPokemonListCellModel) {
        nameLabel.text = cellModel.name
    }
}
