//
//  FavoritePresenter.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/20/20.
//

import SwiftUI
import Combine
import Weekly

class FavoritePresenter: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let router: FavoriteRouter
    private var favoriteUseCase: FavoriteUseCase

    @Published var favorites: [Apod] = []

    init(useCase: FavoriteUseCase, router: FavoriteRouter) {
        self.favoriteUseCase = useCase
        self.router = router
    }

    func getFavorites() {
        favoriteUseCase.getFavorites()
            .sink(receiveCompletion: { _ in
            }, receiveValue: { favorites in
                self.favorites = favorites
            })
            .store(in: &cancellables)
    }

//    func linkBuilder<Content: View>(for apod: WeeklyDomainModel, @ViewBuilder content: () -> Content) -> some View {
//        NavigationLink(
//            destination: router.makeDetailView(for: apod, withFavoritePresenter: self)) {
//            content()
//        }
//    }
}
