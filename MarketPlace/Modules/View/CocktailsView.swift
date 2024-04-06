//
//  CocktailsView.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 05.04.2024.
//

import UIKit
import SnapKit

final class CocktailsView: UIImageView {
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(label)
    }
    
    private func configureLayouts() {
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(8)
        }
    }
    
    func setTitle(_ title: String?) {
        label.text = title
        updateAppearance()
    }
    
    private func updateAppearance() {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        if userInterfaceStyle == .dark {
            label.textColor = .white
            backgroundColor = .darkGray
        } else {
            label.textColor = .black
            backgroundColor = .lightGray
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAppearance()
    }
}
