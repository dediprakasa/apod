//
//  File.swift
//  
//
//  Created by Dedi Prakasa on 1/4/21.
//

import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response

    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
