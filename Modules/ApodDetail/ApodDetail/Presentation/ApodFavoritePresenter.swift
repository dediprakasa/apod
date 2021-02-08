//
//  FavoritePresentation.swift
//  ApodDetail
//
//  Created by Dedi Prakasa on 2/8/21.
//

import SwiftUI
import Core
import Combine

public class ApodFavoritePresenter<FavUseCase: UseCase>: ObservableObject
where FavUseCase.Request == Any,
      FavUseCase.Response == [ApodDetailDomainModel] {

    private var cancellables: Set<AnyCancellable> = []
    private var favUseCase: FavUseCase

    @Published public var favorites: [ApodDetailDomainModel] = []

    public init(favUseCase: FavUseCase) {
        self.favUseCase = favUseCase
    }

    public func getFavorites() {
        favUseCase.execute(request: nil)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { favorites in
                self.favorites = favorites
            })
            .store(in: &cancellables)
    }
}
