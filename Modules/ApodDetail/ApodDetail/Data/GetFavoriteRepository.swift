//
//  GetFavoriteRepository.swift
//  ApodDetail
//
//  Created by Dedi Prakasa on 2/8/21.
//

import Core
import Combine

public struct GetFavoriteRepository<
    ApodDetailLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    ApodDetailLocaleDataSource.Response == ApodDetailModuleEntity,
    RemoteDataSource.Response == [ApodDetailResponse],
    Transformer.Responses == [ApodDetailResponse],
    Transformer.Entities == [ApodDetailModuleEntity],
    Transformer.Domains == [ApodDetailDomainModel] {

    public typealias Request = Any
    public typealias Response = [ApodDetailDomainModel]

    private let localeDataSource: ApodDetailLocaleDataSource
    private let remoteDataSource: RemoteDataSource
    private let mapper: Transformer

    public init(
        localeDataSource: ApodDetailLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {

        self.localeDataSource = localeDataSource
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[ApodDetailDomainModel], Error> {
        return self.localeDataSource.list(request: nil)
            .map { value -> [ApodDetailDomainModel] in
                return self.mapper.transformEntityToDomain(entities: value)
            }
            .eraseToAnyPublisher()
    }
}

