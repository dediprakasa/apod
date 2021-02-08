//
//  ApodDetailRemoteDataSource.swift
//  ApodDetail
//
//  Created by Dedi Prakasa on 2/6/21.
//

import Foundation
import Core
import Combine

public struct ApodDetailRemoteDataSource: DataSource {

    public typealias Request = Any
    
    public typealias Response = [ApodDetailResponse]
    
    public init() {}
    

    public func execute(request: Any?) -> AnyPublisher<[ApodDetailResponse], Error> {
        fatalError()
    }
}
