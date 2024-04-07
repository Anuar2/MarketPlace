//
//  ServiceProvider.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 04.04.2024.
//

import Foundation
import Moya
import RxSwift

// MARK: - ServiceProvider

final class ServiceProvider<Target>: MoyaProvider<Target> where Target: Moya.TargetType {
    
    func request<T: Decodable>(_ target: Target) -> Single<T> {
        return Single<T>.create { [weak self] observer -> Disposable in
            self?.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let successResponse = try response.filterSuccessfulStatusAndRedirectCodes()
                        let decoded = try JSONDecoder().decode(T.self, from: successResponse.data)
                        observer(.success(decoded))
                    } catch let error {
                        observer(.failure(error))
                    }
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}

