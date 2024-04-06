//
//  ViewModel+Extension.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 05.04.2024.
//

import Foundation
import RxSwift

// MARK: - ViewModelOBJ

class ViewModel: NSObject {
    
    let disposeBag: DisposeBag = .init()
    
    deinit {
        print("miss Dispose: \(self)")
    }
}
