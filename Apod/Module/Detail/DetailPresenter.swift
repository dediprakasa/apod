//
//  DetailPresenter.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/29/20.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let detailUseCase: DetailUseCase

    @Published var apod: Apod = Apod(
        id: UUID(),
        apodSite: "",
        copyright: "",
        date: "",
        itemDescription: "No Descrption",
        hdurl: "",
        mediaType: "",
        title: "",
        url: "")
    @Published var errorMessage = ""
    @Published var loadingState = false

    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }

    func setApod(apod: Apod) {
        self.apod = apod
    }

    func updateFavorite() {
        detailUseCase.updateFavorite(apod: apod)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in

            }, receiveValue: { result in
                print(result, "<<<<")
            })
            .store(in: &cancellables)
    }
}
