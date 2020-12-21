//
//  FavoriteRouter.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/21/20.
//

import SwiftUI

class FavoriteRouter {
    func makeDetailView(for favorite: FavoriteEntity) -> some View {
        let presenter = AppContainer().detailPresenter
        let apod = ApodMapper.mapFavoriteEntityToApod(from: favorite)
        presenter.setApod(apod: apod)

        return DetailView(presenter: presenter)
    }
}
