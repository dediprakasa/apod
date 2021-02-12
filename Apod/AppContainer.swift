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

    func provideWeekly<U: UseCase>() -> U where U.Request == (startDate: String, endDate: String), U.Response == [WeeklyDomainModel] {

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

    lazy var homePresenter = WeeklyPresenter(weeklyUseCase: weeklyUseCase)

    func provideDetail<U: UseCase>() -> U where U.Request == Any, U.Response == ApodDetailModuleEntity? {

        let locale = ApodDetailLocaleDataSource(context: PersistenceController.shared.context)
        let remote = ApodDetailRemoteDataSource()

        let mapper = ApodDetailTransformer(context: PersistenceController.shared.context)
        let repository = ApodDetailRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)

        return (Interactor(repository: repository) as? U)!
    }

    func provideDetailFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == Bool {

        let locale = ApodDetailLocaleDataSource(context: PersistenceController.shared.context)
        let remote = ApodDetailRemoteDataSource()

        let mapper = ApodDetailTransformer(context: PersistenceController.shared.context)
        let repository = UpdateFavoriteRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)

        return (Interactor(repository: repository) as? U)!
    }

    func provideFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == [ApodDetailDomainModel] {
        let locale = ApodDetailLocaleDataSource(context: PersistenceController.shared.context)
        let remote = ApodDetailRemoteDataSource()

        let mapper = ApodDetailTransformer(context: PersistenceController.shared.context)
        let repository = GetFavoriteRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)

        return (Interactor(repository: repository) as? U)!
    }

    lazy var apodDetailUseCase: Interactor<
        Any,
        ApodDetailModuleEntity?,
        ApodDetailRepository<
        ApodDetailLocaleDataSource,
        ApodDetailRemoteDataSource,
        ApodDetailTransformer>
    > = self.provideDetail()

    lazy var favDetailUseCase: Interactor<
        Any,
        Bool,
        UpdateFavoriteRepository<
        ApodDetailLocaleDataSource,
        ApodDetailRemoteDataSource,
        ApodDetailTransformer>
    > = self.provideDetailFavorite()

    lazy var favUseCase: Interactor<
        Any,
        [ApodDetailDomainModel],
        GetFavoriteRepository<
        ApodDetailLocaleDataSource,
        ApodDetailRemoteDataSource,
        ApodDetailTransformer>
    > = self.provideFavorite()

    lazy var detailPresenter = ApodDetailPresenter(detailUseCase: apodDetailUseCase, favUseCase: favDetailUseCase)

    lazy var favPresenter = ApodFavoritePresenter(favUseCase: favUseCase)

}
