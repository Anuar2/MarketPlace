//
//  BaseSegmentControl.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 05.04.2024.
//

import UIKit

// MARK: - BaseSegmentControl

final class BaseSegmentControl: UISegmentedControl {
    
    init(items: [String]) {
        super.init(items: items)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
        
        let selectedImageViewIndex = numberOfSegments
        if let selectedImageView = subviews[selectedImageViewIndex] as? UIImageView {
            selectedImageView.backgroundColor = .yellow
            selectedImageView.image = nil
            selectedImageView.bounds = selectedImageView.bounds.insetBy(dx: 2.5, dy: 2.5)
            selectedImageView.layer.masksToBounds = true
            selectedImageView.layer.cornerRadius = bounds.height / 2
            selectedImageView.layer.removeAnimation(forKey: "SelectionBounds")
        }
    }
    
    func configureView() {
        selectedSegmentIndex = 0
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        if userInterfaceStyle == .dark {
            backgroundColor = .gray
            setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        } else {
            backgroundColor = .lightGray
            setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
            setTitleTextAttributes([.foregroundColor: UIColor.darkGray], for: .normal)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         super.traitCollectionDidChange(previousTraitCollection)
         configureView()
     }
}
