//
//  FavoriteRouter.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/21/20.
//

import SwiftUI
import Weekly

class FavoriteRouter {
    func makeDetailView(for apod: WeeklyDomainModel, withFavoritePresenter favoritePresenter: FavoritePresenter) -> some View {
        let presenter = AppContainer().detailPresenter
        presenter.setApod(apod: apod)

        return DetailView(presenter: presenter, favoritePresenter: favoritePresenter)
    }
}
