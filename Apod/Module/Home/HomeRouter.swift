//
//  HomeRouter.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/29/20.
//

import SwiftUI

class HomeRouter {

    func makeDetailView(for apod: Apod) -> some View {
        let detailUseCase = DetailInteractor(apod: apod)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
}
