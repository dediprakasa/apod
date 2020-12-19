//
//  AppContainer.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/30/20.
//

import SwiftUI

class AppContainer {
    
    private init() { }
    
    static let shared = AppContainer()
    
    
    private let remoteDataSource = RemoteDataSource.sharedInstance
    private let localeDataSource = LocalDataSource.sharedInstance
    private lazy var repository = ApodRepository.sharedInstance(remoteDataSource, localeDataSource)
    private lazy var homeInteractor = HomeInteractor(repository: repository)
    private lazy var detailInteractor = DetailInteractor(repository: repository)
    lazy var homePresenter = HomePresenter(homeUseCase: homeInteractor)
    lazy var detailPresenter = DetailPresenter(detailUseCase: detailInteractor)
}
