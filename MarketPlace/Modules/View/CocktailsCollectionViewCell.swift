//
//  CocktailsCollectionViewCell.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 05.04.2024.
//

import UIKit

// MARK: - CocktailsCollectionViewCell

final class CocktailsCollectionViewCell: UICollectionViewCell {
    
    private let cocktailsView: CocktailsView = .init(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(model: CollectionModel) {
        if let strURL = model.imageURL {
            cocktailsView.downloaded(from: strURL)
        }
        cocktailsView.setTitle(model.title)
    }
    
    override func prepareForReuse() {
        cocktailsView.image = nil
        cocktailsView.setTitle(nil)
    }
    
    private func configureCell() {
        
        layer.cornerRadius = 16.0
        layer.masksToBounds = true

        addSubview(cocktailsView)
    }
    
    private func configureLayouts() {
        cocktailsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

