//
//  AppContainer.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/30/20.
//

import SwiftUI
import Core
import Weekly
import CoreData

class AppContainer {
    
//    @Environment(\.managedObjectContext) var context

    private let remoteDataSource = RemoteDataSource.sharedInstance
    private let localeDataSource = LocalDataSource.sharedInstance

    private lazy var repository = ApodRepository.sharedInstance(remoteDataSource, localeDataSource)
    private lazy var homeInteractor = HomeInteractor(repository: repository)
    private lazy var detailInteractor = DetailInteractor(repository: repository)
    private lazy var favoriteInteractor = FavoriteInteractor(repository: repository)

    private lazy var homeRouter = HomeRouter()
    private lazy var favoriteRouter = FavoriteRouter()

    lazy var homePresenter = HomePresenter(useCase: homeInteractor, router: homeRouter)
    lazy var detailPresenter = DetailPresenter(detailUseCase: detailInteractor)
    lazy var favoritePresenter = FavoritePresenter(useCase: favoriteInteractor, router: favoriteRouter)

    func provideWeekly<U: UseCase>() -> U where U.Request == (startDate: String, endDate: String), U.Response == [ApodDomainModel] {
        let locale = GetWeeklyLocaleDataSource(context: Database.shared.context)
         let remote = GetWeeklyRemoteDataSource()
        let mapper = ApodTransformer(context: Database.shared.context)
    
         let repository = GetWeeklyRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)

        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError()
        }

        return interactor
    }
}
