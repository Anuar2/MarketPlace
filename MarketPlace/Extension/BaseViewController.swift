//
//  BaseViewController.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 04.04.2024.
//

import UIKit

// MARK: - BaseViewController
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addSubviews()
        setupLayout()
    }
}

extension BaseViewController: BaseViewControllerProtocol {
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func addSubviews() { }
    
    func setupLayout() { }
}
