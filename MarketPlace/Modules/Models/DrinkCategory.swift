//
//  DrinkCategory.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 04.04.2024.
//

import Foundation

// MARK: - DrinkCategory

enum DrinkCategory: CaseIterable {
    case alcoholic
    case nonAlcoholic
    
    var title: String {
        switch self {
        case .alcoholic:
            return "Alcoholic"
        case .nonAlcoholic:
            return "Non-Alcoholic"
        }
    }
    
    var requestKey: String {
        switch self {
        case .alcoholic:
            return "Alcoholic"
        case .nonAlcoholic:
            return "Non_Alcoholic"
        }
    }
}
