//
//  HomeRouter.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/29/20.
//

import SwiftUI
import Weekly

class HomeRouter {

    func makeDetailView(for apod: WeeklyDomainModel) -> some View {
        let presenter = AppContainer().detailPresenter
        presenter.setApod(apod: apod)

        return DetailView(presenter: presenter)
    }
}
