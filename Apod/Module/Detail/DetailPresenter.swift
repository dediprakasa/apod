//
//  DetailPresenter.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/29/20.
//

import SwiftUI
import Combine
import Weekly
import Core

class DetailPresenter: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private var detailUseCase: DetailUseCase
    var favPresenter: FavoritePresenter?

    @Published var apod: ApodDomainModel? {
        didSet {
            self.checkFavorite()
        }
    }
    @Published var errorMessage = ""
    @Published var loadingState = false
    @Published var isFavorite = false

    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }

    func setApod(apod: ApodDomainModel) {
        self.apod = apod
    }

    func updateFavorite() {
        guard let apod = apod else { return }
//
//        detailUseCase.updateFavorite(apod: apod)
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { _ in
//
//            }, receiveValue: { result in
//                self.isFavorite = result
//            })
//            .store(in: &cancellables)
    }

    func checkFavorite() {
        guard let apod = apod else { return }

//        detailUseCase.checkFavorite(apod: apod)
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { _ in
//
//            }, receiveValue: { result in
//                self.isFavorite = result
//            })
//            .store(in: &cancellables)
    }
}
