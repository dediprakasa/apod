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
    
    lazy var weeklyUseCase: Interactor<
        (startDate: String, endDate: String),
        [ApodDomainModel],
        GetWeeklyRepository<
            GetWeeklyLocaleDataSource,
            GetWeeklyRemoteDataSource,
            ApodTransformer
        >> = AppContainer().provideWeekly()

    @StateObject var homePresenter = GetListPresenter<
        (startDate: String, endDate: String),
        ApodDomainModel,
        Interactor<
            (startDate: String, endDate: String),
            [ApodDomainModel],
            GetWeeklyRepository<
            GetWeeklyLocaleDataSource,
            GetWeeklyRemoteDataSource,
            ApodTransformer
            >
        >>(useCase: AppContainer().provideWeekly())
    @StateObject var favoritePresenter = AppContainer().favoritePresenter

    let persistenceController: Database = {
        let db = Database.shared
        db.prepareDatabase()
        return db
    }()

    var body: some Scene {
        WindowGroup {
                AppView()
                    .environment(\.managedObjectContext, persistenceController.context)
                    .environmentObject(homePresenter)
                    .environmentObject(favoritePresenter)
                    .environmentObject(persistenceController)
        }
    }
}
