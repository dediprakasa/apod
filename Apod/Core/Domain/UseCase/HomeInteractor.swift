//
//  HomeInteractor.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/23/20.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getWeeklyApod(from startDate: String, to endDate: String) -> AnyPublisher<[Apod], Error>
}

class HomeInteractor: HomeUseCase {

    private let repository: ApodRepositoryProtocol

    required init(repository: ApodRepositoryProtocol) {
        self.repository = repository
    }

    func getWeeklyApod(from startDate: String, to endDate: String) -> AnyPublisher<[Apod], Error> {
        return repository.getRangedApods(from: startDate, to: endDate)
    }
}
