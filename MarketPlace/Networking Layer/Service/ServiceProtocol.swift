//
//  ServiceProtocol.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 04.04.2024.
//

import Foundation
import RxSwift

// MARK: - ServiceProtocol
protocol CocktailsServiceProtocol {
    func getCocktails(with type: DrinkCategory) -> Single<CocktailsResponse>
    func getDetails(of cocktail: Cocktail) -> Single<CocktailsResponse>
}

// MARK: - CocktailsService

final class CocktailsService: BaseService<CocktailsAPI>, CocktailsServiceProtocol {
    
    func getCocktails(with type: DrinkCategory) -> RxSwift.Single<CocktailsResponse> {
        deCodableRequest(.getCocktails(type: type))
    }
    
    func getDetails(of cocktail: Cocktail) -> RxSwift.Single<CocktailsResponse> {
        deCodableRequest(.getDetails(cocktail: cocktail))
    }
}


