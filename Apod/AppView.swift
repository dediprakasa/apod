//
//  AppView.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/3/20.
//

import SwiftUI
import Core
import Weekly

struct AppView: View {
    @EnvironmentObject var homePresenter: GetListPresenter<(startDate: String, endDate: String), WeeklyDomainModel, Interactor<(startDate: String, endDate: String), [WeeklyDomainModel], GetWeeklyRepository<GetWeeklyLocaleDataSource, GetWeeklyRemoteDataSource, WeeklyTransformer>>>
    @EnvironmentObject var favoritePresenter: FavoritePresenter

    var body: some View {
        TabView {
            Home(presenter: homePresenter)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            Favorite(presenter: favoritePresenter)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }

            Profile()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
