//
//  LocalDataSource.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/5/20.
//

import Foundation
import Combine

protocol LocalDataSourceProtocol {

    func addWeeklyApods(from apods: [Apod]) -> AnyPublisher<Bool, Error>
}

class LocalDataSource: NSObject {

    static let sharedInstance = LocalDataSource()

    private override init() { }
}

//extension LocalDataSource: LocalDataSourceProtocol {
//    func addWeeklyApods(from apods: [Apod]) -> AnyPublisher<Bool, Error> {
//        return Future<Bool, Error> { promise in
//            
//        }
//    }
//    
//    
//}
