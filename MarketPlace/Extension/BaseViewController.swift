//
//  BaseViewController.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 04.04.2024.
//

import UIKit
import RxSwift

// MARK: - BaseViewController

class BaseViewController: NiblessViewController {
    
    let disposeBag: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    func commonInit() {
        configureView()
        setupLayout()
        bind()
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
        
    func setupLayout() { }
    
    func bind() { }

}
