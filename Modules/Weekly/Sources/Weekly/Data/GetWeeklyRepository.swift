//
//  File.swift
//  
//
//  Created by Dedi Prakasa on 1/10/21.
//

import Core
import Combine

public struct GetWeeklyRepository<WeeklyLocaleDataSource: LocaleDataSource,
                                  RemoteDataSource: DataSource,
                                  Transformer: Mapper>: Repository
where WeeklyLocaleDataSource.Response == ApodModuleEntity,
    RemoteDataSource.Response == [ApodResponse],
    Transformer.Response == [ApodResponse],
    Transformer.Entity == [ApodModuleEntity],
    Transformer.Domain == [ApodDomainModel] {

    public typealias Request = (startDate: String, endDate: String)
    public typealias Response = [ApodDomainModel]

    private let _loacaleDataSource: WeeklyLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer

    public init(
        localeDataSource: WeeklyLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer
    ) {
        _loacaleDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }

    public func execute(request: (startDate: String, endDate: String)?) -> AnyPublisher<[ApodDomainModel], Error> {
        return _loacaleDataSource.list(request: nil)
            .flatMap { result -> AnyPublisher<[ApodDomainModel], Error> in
                if result.isEmpty {
                    guard let request = request else {
                        fatalError()
                    }
                    guard let params = (startDate: request.startDate,
                                        endDate: request.endDate) as? RemoteDataSource.Request else {
                        fatalError()
                    }
                    return _remoteDataSource.execute(request: params)
                        .map { _mapper.transformResponseToEntity(response: $0 )}
                        .flatMap { _loacaleDataSource.add(entities: $0) }
                        .map { _mapper.transformEntityToDomain(entity: $0 )}
                        .eraseToAnyPublisher()
                } else {
                    return _loacaleDataSource.list(request: nil)
                        .map { _mapper.transformEntityToDomain(entity: $0 )}
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
