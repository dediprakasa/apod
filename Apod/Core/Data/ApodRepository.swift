//
//  ApodRepository.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/25/20.
//

import Foundation
import Combine

protocol ApodRepositoryProtocol {
    func getRangedApods(from startDate: String, to endDate: String) -> AnyPublisher<[Apod], Error>
}

class ApodRepository {
    
    let remote: RemoteDataSourceProtocol
    var startDate: String? = ""
    var endDate: String? = ""
    private init(remote: RemoteDataSourceProtocol) {
        self.remote = remote
    }
    
    static let sharedInstance: (RemoteDataSourceProtocol) -> ApodRepository = { remoteRepo in
        return ApodRepository(remote: remoteRepo)
    }
}

extension ApodRepository: ApodRepositoryProtocol {
    func getRangedApods(from startDate: String, to endDate: String) -> AnyPublisher<[Apod], Error> {
        return self.remote.getRangedApods(from: startDate, to: endDate)
            .map { ApodMapper.mapToDomains(from: $0 )}
            .eraseToAnyPublisher()
    }

}
