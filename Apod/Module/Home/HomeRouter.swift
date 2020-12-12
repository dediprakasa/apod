//
//  HomeRouter.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/29/20.
//

import SwiftUI

class HomeRouter {

    func makeDetailView(for apod: Apod) -> some View {
        let presenter = AppContainer().detailPresenter
        presenter.setDate(date: apod.date)
        return DetailView(presenter: presenter)
    }
}
