//
//  ViewModel.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 05.04.2024.
//

import Foundation
import RxRelay
import RxSwift

final class MarketPlaceViewModel: ViewModel, ViewModelType {
    
    private var alcCocktailsSectionsRelay: PublishRelay<[CocktailSection]> = .init()
    private var nonAlcCocktailsSectionsRelay: PublishRelay<[CocktailSection]> = .init()
    
    struct Input {
        var fetchCocktails: Observable<DrinkCategory>
        var searchQuery: Observable<String>
    }
    
    struct Output {
        var alcCocktailsSections: Observable<[CocktailSection]>
        var nonAlcCocktailsSections: Observable<[CocktailSection]>
    }
    
    private let cocktailService: CocktailsServiceProtocol
    
    init(cocktailService: CocktailsServiceProtocol) {
        self.cocktailService = cocktailService
    }
    
    func transform(input: Input) -> Output {
        
        input.fetchCocktails
            .flatMap({ [weak self] type -> Observable<([Cocktail], DrinkCategory)> in
                guard let self else {
                    return .empty()
                }
                return self.updateCocktails(type: type).map { ($0, type) }
            })
            .subscribe(onNext: { [weak self] cocktails, type in
                switch type {
                case .alcoholic:
                    self?.alcCocktailsSectionsRelay.accept([.init(model: type.requestKey, items: cocktails)])
                case .nonAlcoholic:
                    self?.nonAlcCocktailsSectionsRelay.accept([.init(model: type.requestKey, items: cocktails)])
                }
            })
            .disposed(by: disposeBag)
        
        return .init(
            alcCocktailsSections: alcCocktailsSectionsRelay.asObservable(),
            nonAlcCocktailsSections: nonAlcCocktailsSectionsRelay.asObservable()
        )
    }
    
    func updateCocktails(type: DrinkCategory) -> Observable<[Cocktail]> {
        cocktailService.getCocktails(with: type)
            .asObservable()
            .map { $0.drinks }
    }
}
