//
//  Interactor.swift
//  Core
//
//  Created by Dedi Prakasa on 1/24/21.
//

import Foundation
import Combine

public struct Interactor<Request, Response, R: Repository>: UseCase
where R.Request == Request, R.Response == Response {
    
    private let repository: R
    
    public init(repository: R) {
        self.repository = repository
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        self.repository.execute(request: request)
    }
    
}
