//
//  GetRemoteWeeklyDataSource.swift
//  Weekly
//
//  Created by Dedi Prakasa on 1/16/21.
//

import Foundation
import Core
import Combine

public struct GetWeeklyRemoteDataSource: DataSource {
    
    public typealias Request = (startDate: String, endDate: String)
    public typealias Response = [ApodResponse]
    private let session = URLSession(configuration: .default)

    private var apodFetcher = ApodFetcher()
    
    private var startDate: String {
        let date = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.string(from: date)
    }

    private var endDate: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.string(from: date)
    }


    public init() {}

    public func execute(request: (startDate: String, endDate: String)?) -> AnyPublisher<[ApodResponse], Error> {
//        guard let request = request else {
//            let error = ApodError.network(description: "Request error")
//            return Fail(error: error).eraseToAnyPublisher()
//        }
        let components = apodFetcher.createRangedApodsComponents(from: startDate, to: endDate)
        guard let url = components.url else {
            let error = ApodError.network(description: "URL not found")
            return Fail(error: error).eraseToAnyPublisher()
        }

        print(url, ">>>>>>>")
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
