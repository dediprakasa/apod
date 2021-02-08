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
        let apodDetail = ApodMapper.mapWeeklyToDetail(from: apod)
        presenter.setApod(apod: apodDetail)

        return DetailView(presenter: presenter, favoritePresenter: favoritePresenter)
    }
}
