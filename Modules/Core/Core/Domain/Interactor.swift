//
//  Interactor.swift
//  Core
//
//  Created by Dedi Prakasa on 1/15/21.
//

import Foundation
import Combine

public struct Interactor<Request, Response, Repo: Repository>: UseCase
where Repo.Request == Request, Repo.Response == Response {
    private let repository: Repo
    
    public init(repository: Repo) {
        self.repository = repository
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        self.repository.execute(request: request)
    }
}
