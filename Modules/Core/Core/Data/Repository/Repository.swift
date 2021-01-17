//
//  Repository.swift
//  Core
//
//  Created by Dedi Prakasa on 1/15/21.
//

import Foundation
import Combine

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
