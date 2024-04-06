//
//  CocktailDetailViewController.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 06.04.2024.
//

import UIKit
import Then
import RxSwift
import RxCocoa

final class CocktailDetailViewController: BaseViewController {
    
    let cocktail: Cocktail
    
    private let cocktailsView: CocktailsView = .init(frame: .zero)
    
//    private lazy var backButton = UIButton().then {
//        let image = UIImage(named: "cocktailBackButtonIcon")
//        $0.setImage(image, for: .normal)
//        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//    }
    
    private let backButton = UIButton(type: .custom)
    
    private lazy var instructionLabel = UILabel().then {
        $0.textColor = .yellow
        $0.text = "Instructions"
        $0.numberOfLines = 0
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    
    private let backButtonTappedSubject = PublishSubject<Void>()
    var backButtonTapped: Observable<Void> {
        return backButtonTappedSubject.asObservable()
    }
    
    
    init(cocktail: Cocktail) {
        self.cocktail = cocktail
    }
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        set(model: .init(imageURL: cocktail.imageStrURL, title: cocktail.title))
    }
    
    func set(model: CollectionModel) {
        if let strURL = model.imageURL {
            cocktailsView.downloaded(from: strURL)
        }
        cocktailsView.setTitle(model.title)
    }
    
    override func configureView() {
        view.backgroundColor = .white
        [cocktailsView, backButton].forEach { view.addSubview($0) }
        backButton.setImage(UIImage(named: "cocktailBackButtonIcon"), for: .normal)
    }
    
    override func setupLayout() {
        super.setupLayout()
        cocktailsView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(-10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(375)
        }

        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.width.height.equalTo(30)
        }
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

