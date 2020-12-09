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

    var body: some Scene {
        WindowGroup {
//            NavigationView {
                AppView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            }
        }
    }
}
