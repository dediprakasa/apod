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
    
    public typealias Request = Any
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
    
    public func execute(from startDate: String, to endDate: String) -> AnyPublisher<[ApodDomainModel], Error> {

        return _loacaleDataSource.list()
            .flatMap { result -> AnyPublisher<[ApodModuleEntity], Error> in
                if result.isEmpty {
                    return _remoteDataSource.execute(from: startDate, to: endDate)
                        .map { _mapper.mapApodResponsesToEntities(from: $0 )}
                        .flatMap { _loacaleDataSource.addWeeklyApods(from: $0) }
                        .map { _mapper.mapApodEntitiesToDomains(from: $0 )}
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getApods()
                        .map { _mapper.mapApodEntitiesToDomains(from: $0 )}
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
                                  
