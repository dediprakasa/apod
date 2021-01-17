//
//  GetListPresenter.swift
//  Core
//
//  Created by Dedi Prakasa on 1/15/21.
//

import Foundation
import SwiftUI
import Combine

public class GetListPresenter<Request, Response, Interactor: UseCase>: ObservableObject
where Interactor.Request == Request, Interactor.Response == [Response] {
    private var cancellables = Set<AnyCancellable>()
    private let useCase: Interactor

    @Published public var list = [Response]()
    @Published public var errorMessage = ""
    @Published public var isLoading = false
    @Published public var isError = false

    public init(useCase: Interactor) {
        self.useCase = useCase
    }

    public func execute(request: Request?) {
        isLoading = true
        useCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                }
            }, receiveValue: { list in
                self.list = list
            })
            .store(in: &cancellables)
    }
}
