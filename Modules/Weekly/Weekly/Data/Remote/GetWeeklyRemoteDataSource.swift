//
//  GetWeeklyReomoteDataSource.swift
//  Weekly
//
//  Created by Dedi Prakasa on 2/2/21.
//

import Combine
import Foundation
import Core

public struct GetWeeklyRemoteDataSource: DataSource {

    public typealias Request = (startDate: String, endDate: String)
    public typealias Response = [WeeklyApodResponse]

    private let session = URLSession(configuration: .default)
    private var weeklyFetcher = WeeklyFetcher()

    public init() {}

    public func execute(request: (startDate: String, endDate: String)?) -> AnyPublisher<[WeeklyApodResponse], Error> {
        let components = weeklyFetcher.createRangedApodsComponents(
            from: request?.startDate ?? "",
            to: request?.endDate ?? "")

        guard let url = components.url else {
            let error = WeeklyError.network(description: "URL not found")
            return Fail(error: error).eraseToAnyPublisher()
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return session.dataTaskPublisher(for: url)
            .mapError { _ -> Error in
                WeeklyError.network(description: "Something went wrong")
            }
            .map { $0.data }
            .decode(type: [WeeklyApodResponse].self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
