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

// MARK: - CocktailDetailViewController

final class CocktailDetailViewController: BaseViewController {
    
    let cocktail: Cocktail
    var isAlcoholic: Bool? = false
    
    private let cocktailsView: CocktailsView = .init(frame: .zero)
    
    private let backButton = UIButton(type: .custom)
    
    private let cocktailsGlassView = UIView().then {
        $0.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        $0.layer.cornerRadius = 20
    }
    
    private let cocktailsIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let coctailsGlassLabel = UILabel().then {
        $0.text = "Coctail glass"
        $0.textColor = .orange
    }
    
    private let cocktailsCategoryView = UIView().then {
        $0.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        $0.layer.cornerRadius = 20
    }
    
    private let cocktailsCategoryLabel = UILabel().then {
        $0.textColor = .blue
    }
    
    private lazy var horizontalStackView = UIStackView(arrangedSubviews: [cocktailsGlassView, cocktailsCategoryView]).then {
        $0.axis = .horizontal
        $0.spacing = 16
    }
    
    private lazy var cocktailsHorizontalView = UIStackView(arrangedSubviews: [cocktailsIcon, coctailsGlassLabel]).then {
         $0.axis = .horizontal
         $0.spacing = 16
     }
    
    private lazy var instructionLabel = UILabel().then {
        $0.textColor = .orange
        $0.text = "Instructions"
        $0.numberOfLines = 0
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "Place all ingredients in a cocktail shaker. Shake for 15 seconds without ice. Add ice to the cocktail shaker and shake again for 30 seconds. Strain into a glass and garnish."
    }
    
    private let backButtonTappedSubject = PublishSubject<Void>()
    var backButtonTapped: Observable<Void> {
        return backButtonTappedSubject.asObservable()
    }
    
    
    init(cocktail: Cocktail, isAlcoholic: Bool) {
        self.cocktail = cocktail
        self.isAlcoholic = isAlcoholic
    }
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        set(model: .init(imageURL: cocktail.imageStrURL, title: cocktail.title))
        cocktailsCategoryLabel.text = isAlcoholic ?? false ? "Alcoholic" : "NonAlcoholic"
    }
    
    func set(model: CollectionModel) {
        if let strURL = model.imageURL {
            cocktailsView.downloaded(from: strURL)
        }
        cocktailsView.setTitle(model.title)
    }
    
    override func configureView() {
        view.backgroundColor = .white
        [cocktailsView,
         horizontalStackView,
         instructionLabel,
         descriptionLabel,
         backButton
        ].forEach { view.addSubview($0) }
        backButton.setImage(UIImage(named: "cocktailBackButtonIcon"), for: .normal)
        cocktailsIcon.image = UIImage(named: "cocktailsIcon")

        cocktailsGlassView.addSubview(cocktailsHorizontalView)
        
        cocktailsCategoryView.addSubview(cocktailsCategoryLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        cocktailsView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(375)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.width.height.equalTo(30)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.top.equalTo(cocktailsView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(56)
        }
        
        cocktailsGlassView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        cocktailsCategoryView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        cocktailsCategoryLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        cocktailsHorizontalView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(horizontalStackView.snp.bottom).offset(36)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(instructionLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-208)
        }
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

