//
//  Cocktails.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 04.04.2024.
//

import Foundation
import Differentiator

// MARK: - CocktailsResponse

struct CocktailsResponse: Decodable {
    let drinks: [Cocktail]
}

// MARK: - Cocktail

struct Cocktail: Decodable, IdentifiableType, Equatable {
    
    typealias Identity = String
    
    var identity: Identity {
        id
    }
    
    let id: Identity
    var title: String?
    var imageStrURL: String?
    var strAlcoholic: String?
    var strGlass: String?
    
    /// Если появится кейс с camelCase, можно использовать  keyDecodingStrategy = .convertFromSnakeCase внутри Decoder

    static func == (lhs: Cocktail, rhs: Cocktail) -> Bool {
        lhs.identity == rhs.identity
    }
}
