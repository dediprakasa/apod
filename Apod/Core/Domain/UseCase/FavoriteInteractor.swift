//
//  FavoriteInteractor.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/20/20.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func getFavorites() -> AnyPublisher<[FavoriteEntity], Error>
}

class FavoriteInteractor: FavoriteUseCase {

    private let repository: ApodRepositoryProtocol

    init(repository: ApodRepository) {
        self.repository = repository
    }

    func getFavorites() -> AnyPublisher<[FavoriteEntity], Error> {
        return repository.getFavorites()
    }
}
