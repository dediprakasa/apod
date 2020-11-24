//
//  ApodFetcher.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/24/20.
//

import Foundation
import Combine

protocol ApodFetcherProtocol {
    
    func getRangedApods(from startDate: String, to endDate: String) -> AnyPublisher<[ApodResponse], Error>
    
    
}

class ApodFetcher {
    
    private let session:  URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension ApodFetcher: ApodRepositoryProtocol {
    func getRangedApods(from startDate: String, to endDate: String) -> AnyPublisher<[ApodResponse], Error> {
        let components = createRangedApodsComponents(from: startDate, to: endDate)
        guard let url = components.url else {
            //TODO
            let error = ApodError.network(description: "URL not found")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .mapError { error in
                ApodError.network(description: "Something went wrong")
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                //TODO
                return Just([ApodResponse]())
            }
            .eraseToAnyPublisher()
        
    }
    
    
}

private extension ApodFetcher {
    
    struct ApodAPI {
        static let scheme = "https"
        static let host   = "apodapi.herokuapp.com"
        static let path   = "api"
    }
    
    func createRangedApodsComponents(from startDate: String, to endDate: String) ->URLComponents {
        var components = URLComponents()
        components.scheme = ApodAPI.scheme
        components.host   = ApodAPI.host
        components.path   = ApodAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "start_date", value: startDate),
            URLQueryItem(name: "end_date", value: endDate)
        ]
        
        return components
    }
    
    enum ApodError: Error {
      case parsing(description: String)
      case network(description: String)
    }
}
