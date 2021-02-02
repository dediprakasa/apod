//
//  Fetcher.swift
//  Weekly
//
//  Created by Dedi Prakasa on 2/2/21.
//

import Foundation

protocol WeeklyFetcherProtocol {

    func createRangedApodsComponents(from startDate: String, to endDate: String) -> URLComponents
    func createSingleApodComponents(onDate date: String) -> URLComponents
}

public class WeeklyFetcher: WeeklyFetcherProtocol {

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

enum WeeklyError: Error {
  case parsing(description: String)
  case network(description: String)
}
