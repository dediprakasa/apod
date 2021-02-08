//
//  ApodDetailPresenter.swift
//  ApodDetail
//
//  Created by Dedi Prakasa on 2/6/21.
//

import SwiftUI
import Combine
import Core

public class ApodDetailPresenter<ApodUseCase: UseCase, FavUseCase: UseCase>: ObservableObject
where ApodUseCase.Request == Any,
      ApodUseCase.Response == ApodDetailDomainModel,
      FavUseCase.Request == Any,
      FavUseCase.Response == Bool {

    private var cancellables: Set<AnyCancellable> = []
    private var detailUseCase: ApodUseCase
    private var favUseCase: FavUseCase

    @Published public var apod: ApodDetailDomainModel? {
        didSet {
//            self.checkFavorite()
        }
    }
    @Published public var errorMessage = ""
    @Published public var loadingState = false
    @Published public var isFavorite = false

    public init(detailUseCase: ApodUseCase, favUseCase: FavUseCase) {
        self.detailUseCase = detailUseCase
        self.favUseCase = favUseCase
    }

    public func setApod(apod: ApodDetailDomainModel) {
        self.apod = apod
    }

    public func updateFavorite() {
        print("+++++++++")
        guard let apod = apod else { return }
        print(">>>>>>>>>>>")
        favUseCase.execute(request: apod)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { val in
                print(val, ",<<<")
            }, receiveValue: { result in
                self.isFavorite = true
                print("------", result)
            })
            .store(in: &cancellables)
    }

    public func checkFavorite() {
        guard let apod = apod else { return }

        detailUseCase.execute(request: apod.date)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in

            }, receiveValue: { result in
                print(result, "<<<<<")
                self.isFavorite = true
            })
            .store(in: &cancellables)
    }
}
