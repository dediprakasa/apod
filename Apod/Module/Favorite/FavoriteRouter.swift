//
//  FavoriteRouter.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/21/20.
//

import SwiftUI
import Weekly
import Core
import ApodDetail

class FavoriteRouter {
    func makeDetailView(for apod: ApodDetailDomainModel, withFavoritePresenter favoritePresenter: ApodFavoritePresenter<Interactor
                                <
                                Any,
                                [ApodDetailDomainModel],
                                GetFavoriteRepository
                                    <
                                        ApodDetailLocaleDataSource,
                                        ApodDetailRemoteDataSource,
                                        ApodDetailTransformer
                                    >
                                >>) -> some View {
        let presenter = AppContainer().detailPresenter
        presenter.setApod(apod: apod)

        return DetailView(presenter: presenter, favoritePresenter: favoritePresenter)
    }
}
