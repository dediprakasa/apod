//
//  ResponseDataSource.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/25/20.
//

import Foundation
import Combine

protocol RemoteDataSourceProtocol {
    func getRangedApods(from startDate: String, to endDate: String) -> AnyPublisher<[ApodResponse], Error>
}

class RemoteDataSource: NSObject {

    static let sharedInstance: RemoteDataSource = RemoteDataSource()
    private let session = URLSession(configuration: .default)
    private var apodFetcher: ApodFetcherProtocol = ApodFetcher()

    private override init() { }

}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getRangedApods(from startDate: String, to endDate: String) -> AnyPublisher<[ApodResponse], Error> {
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
