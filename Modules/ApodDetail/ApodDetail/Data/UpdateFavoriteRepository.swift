//
//  GetGameRepository.swift
//  ApodDetail
//
//  Created by Dedi Prakasa on 2/4/21.
//

import Core
import Combine

public struct UpdateFavoriteRepository<
    ApodDetailLocaleDataSource: DetailLocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    ApodDetailLocaleDataSource.Response == ApodDetailModuleEntity,
    RemoteDataSource.Response == [ApodDetailResponse],
    Transformer.Responses == [ApodDetailResponse],
    Transformer.Entities == [ApodDetailModuleEntity],
    Transformer.Domains == [ApodDetailDomainModel] {

    public typealias Request = Any
    public typealias Response = Bool

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

    public func execute(request: Any?) -> AnyPublisher<Bool, Error> {
        return self.localeDataSource.update(apod: request)
            .eraseToAnyPublisher()
    }
}
