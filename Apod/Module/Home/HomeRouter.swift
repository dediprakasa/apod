//
//  HomeRouter.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/29/20.
//

import SwiftUI
import Weekly
import ApodDetail

class HomeRouter {

    func makeDetailView(for apod: WeeklyDomainModel) -> some View {
        let presenter = AppContainer().detailPresenter
        let apodDetail = ApodMapper.mapWeeklyToDetail(from: apod)
        presenter.setApod(apod: apodDetail)

        return DetailView(presenter: presenter)
    }
}
