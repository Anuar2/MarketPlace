//
//  BaseViewControllerProtocol.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 04.04.2024.
//

import Foundation
import UIKit

// MARK: - BaseViewControllerProtocol
protocol BaseViewControllerProtocol where Self: UIViewController {
    func configureView()
    func addSubviews()
    func setupLayout()
}

