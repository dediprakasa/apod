//
//  ApodFetcher.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/24/20.
//

import Foundation

struct ApodFetcher {
    private let session:  URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension ApodFetcher {
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
}
