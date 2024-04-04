//
//  BaseService.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 04.04.2024.
//

import Moya
import RxSwift

// MARK: - BaseService
class BaseService<T: TargetType> {
    
    private let provider: ServiceProvider<T>
    
    init(provider: ServiceProvider<T>) {
        self.provider = provider
    }
    
    func deCodableRequest<C: Decodable>(_ target: T) -> Single<C> {
        provider.request(target)
    }
}
