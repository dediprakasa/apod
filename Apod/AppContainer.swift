//
//  AppContainer.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/30/20.
//

import Foundation

class AppContainer {
    private let remoteDataSource = RemoteDataSource.sharedInstance
    private lazy var repository = ApodRepository.sharedInstance(remoteDataSource)
    private lazy var homeInteractor = HomeInteractor(repository: repository)
    lazy var homePresenter = HomePresenter(homeUseCase: homeInteractor)
}
