//
//  DetailInteractor.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/29/20.
//

import Foundation

protocol DetailUseCase {
    func getApod() -> Apod
}

class DetailInteractor: DetailUseCase {
    private let apod: Apod
    
    init(apod: Apod) {
        self.apod = apod
    }
    
    func getApod() -> Apod {
        return apod
//        return Apod(apodSite: "", copyright: "", date: "", itemDescription: "", hdurl: "", mediaType: "", title: "", url: "")
    }
    
    
}
