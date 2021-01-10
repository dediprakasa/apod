//
//  File.swift
//  
//
//  Created by Dedi Prakasa on 1/10/21.
//

import Foundation
import Core
import Combine

public struct GetWeeklyRemoteDataSource: DataSource {
    public typealias Request = Any
    public typealias Response = [ApodResponse]

    private let _endpoint: String

    private var apodFetcher = ApodFetcher()
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }

    public func getWeeklyApods(from startDate: String, to endDate: String) -> AnyPublisher<[ApodResponse], Error> {
        let components = apodFetcher.createRangedApodsComponents(from: startDate, to: endDate)
        guard let url = components.url else {
            let error = ApodError.network(description: "URL not found")
            return Fail(error: error).eraseToAnyPublisher()
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return session.dataTaskPublisher(for: url)
            .mapError { _ -> Error in
                ApodError.network(description: "Something went wrong")
            }
            .map { $0.data }
            .decode(type: [ApodResponse].self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

