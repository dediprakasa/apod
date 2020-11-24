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

class RemoteDataSource {
    
    private var apodFetcher: ApodFetcherProtocol
    var startDate: String? = ""
    var endDate: String? = ""
    
    init(apodFetcher: ApodFetcherProtocol) {
        self.apodFetcher = apodFetcher
    }
    
    static let sharedInstance: (ApodFetcherProtocol) -> RemoteDataSource = { fetcher in
        return RemoteDataSource(apodFetcher: fetcher)
    }
}

// TODO
//extension RemoteDataSource: RemoteDataSourceProtocol {
//    func getRangedApods(from startDate: String, to endDate: String) -> AnyPublisher<[ApodResponse], Error> {
//
//    }
  
