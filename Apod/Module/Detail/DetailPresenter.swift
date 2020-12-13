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

    @Published var apod: Apod = Apod(id: UUID(), apodSite: "", copyright: "", date: "", itemDescription: "No Descrption", hdurl: "", mediaType: "", title: "", url: "")
    @Published var errorMessage = ""
    @Published var loadingState = false
    var date: String?

    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        getApod()
    }

    func setDate(date: String) {
        self.date = date
    }

    func getApod() {
        detailUseCase.getApod(onDate: date ?? "")
            .receive(on: RunLoop.main)
            .sink { promise in
                switch promise {
                case .failure:
                    self.errorMessage = String(describing: promise)
                    print(self.errorMessage)
                case .finished:
                    self.loadingState = false
                }
            } receiveValue: { apods in
                DispatchQueue.main.async {
                    self.apod = apods[0]
                }
            }.store(in: &cancellables)
    }
}
