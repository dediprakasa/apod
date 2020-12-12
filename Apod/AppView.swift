//
//  AppView.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/3/20.
//

import SwiftUI

struct AppView: View {

    var body: some View {
        TabView {
            Home(presenter: AppContainer().homePresenter)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            Favorite()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }

            Search()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
