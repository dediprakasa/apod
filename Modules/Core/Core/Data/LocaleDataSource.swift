//
//  LocaleDataSource.swift
//  Core
//
//  Created by Dedi Prakasa on 1/24/21.
//

import Foundation
import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<[Response], Error>
    func get(id: String) -> AnyPublisher<Response, Error>
    func update(id: String) -> AnyPublisher<Bool, Error>
}