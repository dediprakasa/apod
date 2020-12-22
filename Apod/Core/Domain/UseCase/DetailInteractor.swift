//
//  DetailInteractor.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/29/20.
//

import Foundation
import Combine

protocol DetailUseCase {
    func getApod(onDate date: String) -> AnyPublisher<[Apod], Error>
    func updateFavorite(apod: Apod) -> AnyPublisher<Bool, Error>
    func checkFavorite(apod: Apod) -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUseCase {

    private let repository: ApodRepositoryProtocol

    init(repository: ApodRepository) {
        self.repository = repository
    }

    func getApod(onDate date: String) -> AnyPublisher<[Apod], Error> {
        return repository.getApod(onDate: date)
    }

    func updateFavorite(apod: Apod) -> AnyPublisher<Bool, Error> {
        return repository.updateFavorite(apod: apod)
    }

    func checkFavorite(apod: Apod) -> AnyPublisher<Bool, Error> {
        return repository.checkFavorite(apod: apod)
    }
}
