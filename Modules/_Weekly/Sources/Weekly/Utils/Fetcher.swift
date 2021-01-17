//
//  File.swift
//  
//
//  Created by Dedi Prakasa on 1/10/21.
//

import Foundation
import Combine

class ApodFetcher {

    struct ApodAPI {
        static let scheme = "https"
        static let host   = "apodapi.herokuapp.com"
        static let path   = "/api"
    }

    func createRangedApodsComponents(from startDate: String, to endDate: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = ApodAPI.scheme
        components.host   = ApodAPI.host
        components.path   = ApodAPI.path

        components.queryItems = [
            URLQueryItem(name: "start_date", value: startDate),
            URLQueryItem(name: "end_date", value: endDate),
            URLQueryItem(name: "thumbs", value: "true")
        ]

        return components
    }
}

enum ApodError: Error {
  case parsing(description: String)
  case network(description: String)
}
