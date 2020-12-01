//
//  ApodApp.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/14/20.
//

import SwiftUI

@main
struct ApodApp: App {
    let persistenceController = PersistenceController.shared
    let appContainer = AppContainer()

    var body: some Scene {
        WindowGroup {
            Home(presenter: appContainer.homePresenter)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
