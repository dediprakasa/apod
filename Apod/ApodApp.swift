//
//  ApodApp.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/14/20.
//

import SwiftUI
import Core
import Weekly

@main
struct ApodApp: App {

    @StateObject var homePresenter = AppContainer().homePresenter
    @StateObject var favoritePresenter = AppContainer().favoritePresenter

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
                AppView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(homePresenter)
                    .environmentObject(favoritePresenter)
        }
    }
}
