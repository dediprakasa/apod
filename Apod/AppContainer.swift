//
//  AppContainer.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/30/20.
//

import SwiftUI
import Core
import Weekly
import ApodDetail

class AppContainer {

    private let remoteDataSource = RemoteDataSource.sharedInstance
    private let localeDataSource = LocalDataSource.sharedInstance

    private lazy var repository = ApodRepository.sharedInstance(remoteDataSource, localeDataSource)
    private lazy var homeInteractor = HomeInteractor(repository: repository)
    private lazy var detailInteractor = DetailInteractor(repository: repository)
    private lazy var favoriteInteractor = FavoriteInteractor(repository: repository)

    private lazy var homeRouter = HomeRouter()
    private lazy var favoriteRouter = FavoriteRouter()

    lazy var weeklyLocale = GetWeeklyLocaleDataSource(context: PersistenceController.shared.context)
    lazy var weeklyRemote = GetWeeklyRemoteDataSource()
    lazy var weeklyMapper = WeeklyTransformer(context: PersistenceController.shared.context)

    lazy var weeklyRepo = GetWeeklyRepository(localeDataSource: self.weeklyLocale, remoteDataSource: self.weeklyRemote, mapper: self.weeklyMapper)

//    lazy var detailPresenter = DetailPresenter(detailUseCase: detailInteractor)
    lazy var favoritePresenter = FavoritePresenter(useCase: favoriteInteractor, router: favoriteRouter)

    func provideWeekly<U: UseCase>() -> U where U.Request == (startDate: String, endDate: String), U.Response == [WeeklyDomainModel] {
        PersistenceController.shared.prepareDatabase()
        
        let locale = GetWeeklyLocaleDataSource(context: PersistenceController.shared.context)
        let remote = GetWeeklyRemoteDataSource()
        
        let mapper = WeeklyTransformer(context: PersistenceController.shared.context)
        
        let repository = GetWeeklyRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)

        return (Interactor(repository: repository) as? U)!
    }

    lazy var weeklyUseCase: Interactor<
        (startDate: String, endDate: String),
        [WeeklyDomainModel],
        GetWeeklyRepository<
        GetWeeklyLocaleDataSource,
        GetWeeklyRemoteDataSource,
        WeeklyTransformer>
    > = self.provideWeekly()

    lazy var homePresenter = GetListPresenter(useCase: weeklyUseCase)

    func provideDetail<U: UseCase>() -> U where U.Request == Any, U.Response == ApodDetailDomainModel {
//        PersistenceController.shared.prepareDatabase()

        let locale = ApodDetailLocaleDataSource(context: PersistenceController.shared.context)
        let remote = ApodDetailRemoteDataSource()

        let mapper = ApodDetailTransformer(context: PersistenceController.shared.context)
        let repository = ApodDetailRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)

        return (Interactor(repository: repository) as? U)!
    }
    
    func provideFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == Bool {
//        PersistenceController.shared.prepareDatabase()

        let locale = ApodDetailLocaleDataSource(context: PersistenceController.shared.context)
        let remote = ApodDetailRemoteDataSource()

        let mapper = ApodDetailTransformer(context: PersistenceController.shared.context)
        let repository = UpdateFavoriteRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)

        return (Interactor(repository: repository) as? U)!
    }

    lazy var apodDetailUseCase: Interactor<
        Any,
        ApodDetailDomainModel,
        ApodDetailRepository<
        ApodDetailLocaleDataSource,
        ApodDetailRemoteDataSource,
        ApodDetailTransformer>
    > = self.provideDetail()

    lazy var favUseCase: Interactor<
        Any,
        Bool,
        UpdateFavoriteRepository<
        ApodDetailLocaleDataSource,
        ApodDetailRemoteDataSource,
        ApodDetailTransformer>
    > = self.provideFavorite()

    lazy var detailPresenter = ApodDetailPresenter(detailUseCase: apodDetailUseCase, favUseCase: favUseCase)
}
