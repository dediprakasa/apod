//
//  FavoritePresenter.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/20/20.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private var favoriteUseCase: FavoriteUseCase

    @Published var favorites: [FavoriteEntity] = []
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
 
    func getFavorites() {
        favoriteUseCase.getFavorites()
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { favorites in
                self.favorites = favorites
            })
            .store(in: &cancellables)

    }
}
