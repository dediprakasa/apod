//
//  AppView.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/3/20.
//

import SwiftUI

struct AppView: View {

    let appContainer = AppContainer()

    var body: some View {
        TabView {
            Home(presenter: appContainer.homePresenter)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            Favorite()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
