//
//  Theme.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 04.04.2024.
//

import UIKit

// MARK: - Theme

enum Theme {
    case light
    case dark
    
    var backgroundColor: UIColor {
        switch self {
        case .light:
            return UIColor.white
        case .dark:
            return UIColor.black
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .light:
            return UIColor.black
        case .dark:
            return UIColor.white
        }
    }
}
