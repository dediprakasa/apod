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

    let remoteDataSource: RemoteDataSource = RemoteDataSource.sharedInstance
    private func getApodRepository() -> ApodRepositoryProtocol { ApodRepository.sharedInstance(remoteDataSource)
    }
    private func getHomeUseCase() -> HomeUseCase {
        return HomeInteractor(repository: getApodRepository())
    }
    private func getHomePresenter() -> HomePresenter { return HomePresenter(homeUseCase: getHomeUseCase())
    }
    var body: some Scene {
        WindowGroup {
            Home(presenter: getHomePresenter())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
