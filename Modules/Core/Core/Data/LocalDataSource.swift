//
//  LocalDataSource.swift
//  Core
//
//  Created by Dedi Prakasa on 1/15/21.
//

import Foundation
import Combine

public protocol LocalDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<[Response], Error>
    func get(id: String) -> AnyPublisher<Response, Error>
    func update(id: Int, entity: Response) -> AnyPublisher<Request, Error>
}
