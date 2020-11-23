//
//  HomeInteractor.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/23/20.
//

import Foundation

protocol HomeUseCase {
    func getWeeklyApod(completion: @escaping (Result<[Apod], Error>) -> Void)
}

class HomeInteractor: HomeUseCase {
    func getWeeklyApod(completion: @escaping (Result<[Apod], Error>) -> Void) {
        //
    }
    
    
}
