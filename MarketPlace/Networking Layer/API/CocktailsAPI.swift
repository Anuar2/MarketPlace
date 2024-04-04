//
//  CocktailsAPI.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 04.04.2024.
//

import Foundation
import Moya

// MARK: - CocktailsAPI
enum CocktailsAPI: TargetType {
    
    case getCocktails(type: DrinkCategory)
    case getDetails(cocktail: Cocktail)
    
    
    var baseURL: URL {
        return URL(string: "https://www.thecocktaildb.com/api")!
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var path: String {
        switch self {
        case .getCocktails:
            "/json/v1/1/filter.php"
        case .getDetails:
            "/json/v1/1/lookup.php"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getCocktails(let type):
            return .requestParameters(parameters: ["a": type.requestKey], encoding: parameterEncoding)
        case .getDetails(let cocktail):
            return .requestParameters(parameters: ["i": cocktail.id], encoding: parameterEncoding)
        }
    }
}
