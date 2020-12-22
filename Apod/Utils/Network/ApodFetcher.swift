//
//  ApodFetcher.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/24/20.
//

import Foundation
import Combine

protocol ApodFetcherProtocol {

    func createRangedApodsComponents(from startDate: String, to endDate: String) -> URLComponents
    func createSingleApodComponents(onDate date: String) -> URLComponents
}

class ApodFetcher: ApodFetcherProtocol {

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

    func createSingleApodComponents(onDate date: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = ApodAPI.scheme
        components.host   = ApodAPI.host
        components.path   = ApodAPI.path

        components.queryItems = [
            URLQueryItem(name: "date", value: date)
        ]

        return components
    }
}

enum ApodError: Error {
  case parsing(description: String)
  case network(description: String)
}
