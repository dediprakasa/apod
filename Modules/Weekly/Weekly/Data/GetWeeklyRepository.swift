//
//  GetWeeklyRepository.swift
//  Weekly
//
//  Created by Dedi Prakasa on 1/16/21.
//

import Foundation
import Combine
import Core

public struct GetWeeklyRepository<WeeklyLocaleDataSource: LocalDataSource,
                                  RemoteDataSource: DataSource,
                                  Transformer: Mapper>: Repository
where WeeklyLocaleDataSource.Response == ApodEntityModule,
    RemoteDataSource.Response == [ApodResponse],
    Transformer.Response == [ApodResponse],
    Transformer.Entity == [ApodEntityModule],
    Transformer.Domain == [ApodDomainModel] {

    public typealias Request = (startDate: String, endDate: String)
    public typealias Response = [ApodDomainModel]

    private let loacaleDataSource: WeeklyLocaleDataSource
    private let remoteDataSource: RemoteDataSource
    private let mapper: Transformer

    public init(
        localeDataSource: WeeklyLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer
    ) {
        self.loacaleDataSource = localeDataSource
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }

    public func execute(request: (startDate: String, endDate: String)?) -> AnyPublisher<[ApodDomainModel], Error> {
        return loacaleDataSource.list(request: nil)
            .flatMap { result -> AnyPublisher<[ApodDomainModel], Error> in
                if result.isEmpty {
//                    guard let request = request else {
//                        fatalError()
//                    }
//                    guard let params = (startDate: request?.startDate ?? "",
//                                        endDate: request?.endDate ?? "") as? RemoteDataSource.Request else {
//                        fatalError()
//                    }
                    return remoteDataSource.execute(request: (startDate: "",
                                                              endDate: "") as? RemoteDataSource.Request)
                        .map { self.mapper.transformResponsesToEntities(responses: $0 )}
                        .flatMap { self.loacaleDataSource.add(entities: $0) }
                        .map { self.mapper.transformEntitiesToDomains(entities: $0 )}
                        .eraseToAnyPublisher()
                } else {
                    return loacaleDataSource.list(request: nil)
                        .map { self.mapper.transformEntitiesToDomains(entities: $0 )}
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
