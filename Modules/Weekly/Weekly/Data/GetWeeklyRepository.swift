//
//  GetWeeklyRepository.swift
//  Weekly
//
//  Created by Dedi Prakasa on 2/2/21.
//

import Core
import Combine

public struct GetWeeklyRepository<
    WeeklyLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    WeeklyLocaleDataSource.Response == WeeklyModuleEntity,
    RemoteDataSource.Response == [WeeklyApodResponse],
    Transformer.Responses == [WeeklyApodResponse],
    Transformer.Entities == [WeeklyModuleEntity],
    Transformer.Domains == [WeeklyDomainModel] {

    public typealias Request = (startDate: String, endDate: String)
    public typealias Response = [WeeklyDomainModel]

    private let localeDataSource: WeeklyLocaleDataSource
    private let remoteDataSource: RemoteDataSource
    private let mapper: Transformer

    public init(
        localeDataSource: WeeklyLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {

        self.localeDataSource = localeDataSource
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }

    public func execute(request: (startDate: String, endDate: String)?) -> AnyPublisher<[WeeklyDomainModel], Error> {
        return self.localeDataSource.list(request: nil)
            .flatMap { result -> AnyPublisher<[WeeklyDomainModel], Error> in
                if result.isEmpty {
                    return self.remoteDataSource.execute(request: request as? RemoteDataSource.Request)
                        .map { self.mapper.transformResponseToEntity(responses: $0 )}
                        .flatMap { self.localeDataSource.add(entities: $0 )}
                        .map { self.mapper.transformEntityToDomain(entities: $0 )}
                        .eraseToAnyPublisher()
                } else {
                    return self.localeDataSource.list(request: nil)
                        .map { self.mapper.transformEntityToDomain(entities: $0 )}
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
