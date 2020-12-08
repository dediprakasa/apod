//
//  ApodRepository.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/25/20.
//

import Foundation
import Combine

protocol ApodRepositoryProtocol {
    func getWeeklyApods(from startDate: String, to endDate: String) -> AnyPublisher<[Apod], Error>
}

class ApodRepository: ApodRepositoryProtocol {

    let remote: RemoteDataSourceProtocol
    let locale: LocalDataSourceProtocol
    private init(remote: RemoteDataSourceProtocol, locale: LocalDataSourceProtocol) {
        self.remote = remote
        self.locale = locale
    }

    static let sharedInstance: (RemoteDataSource, LocalDataSource) -> ApodRepository = { remoteRepo, localeRepo in
        return ApodRepository(remote: remoteRepo, locale: localeRepo)
    }

    func getWeeklyApods(from startDate: String, to endDate: String) -> AnyPublisher<[Apod], Error> {

        return self.locale.getApods()
            .flatMap { result -> AnyPublisher<[Apod], Error> in
                if result.isEmpty {
                    return self.remote.getRangedApods(from: startDate, to: endDate)
                        .map { ApodMapper.mapApodResponsesToEntities(from: $0 )}
                        .flatMap { self.locale.addWeeklyApods(from: $0) }
                        .map { ApodMapper.mapApodEntitiesToDomains(from: $0 )}
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getApods()
                        .map { ApodMapper.mapApodEntitiesToDomains(from: $0 )}
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
