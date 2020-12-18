//
//  Favorite.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/3/20.
//

import SwiftUI

struct Favorite: View {

    @FetchRequest(entity: FavoriteEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteEntity.date, ascending: false)])
    var favs: FetchedResults<FavoriteEntity>

    var body: some View {
        VStack {
            ForEach(favs) { fav in
                Text(fav.title ?? "aa" as String)
            }
        }
    }
}

struct Favorite_Previews: PreviewProvider {
    static var previews: some View {
        Favorite()
    }
}
