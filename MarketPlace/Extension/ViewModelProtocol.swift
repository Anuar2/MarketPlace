//
//  ViewModelProtocol.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 05.04.2024.
//

import Foundation

// MARK: - ViewModelProtocol

protocol ViewModelType: AnyObject {
    
    associatedtype Input
    
    associatedtype Output
    
    func transform(input: Input) -> Output
}
