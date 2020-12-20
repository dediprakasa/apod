//
//  FavoritePresenter.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/20/20.
//

import SwiftUI

class FavoritePresenter: ObservableObject {
    
    @Published var favorites: [Favorite] = []
 
    func getFavorite() {
        
    }
}
