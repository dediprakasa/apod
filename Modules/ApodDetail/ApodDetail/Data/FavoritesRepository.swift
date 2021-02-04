//
//  GetGameRepository.swift
//  ApodDetail
//
//  Created by Dedi Prakasa on 2/4/21.
//

import Core
import Combine

public struct FavoriteRepository<
    ApodDetailLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    ApodDetailLocaleDataSource.Response == ApodDetailModuleEntity,
    RemoteDataSource.Response == Any,
    Transformer.Responses == Any,
    Transformer.Entities == [ApodDetailModuleEntity],
    Transformer.Domains == [ApodDetailDomainModel] {
    
 
    public typealias Request = ApodDetailModuleEntity
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
    
    public func update(request: ApodDetailModuleEntity?) -> AnyPublisher<Bool, Error> {
        return self.localeDataSource.update(apod: request)
            .eraseToAnyPublisher()
        
    }
}
