//
//  Favorite.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/3/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct Favorite: View {

    @FetchRequest(entity: FavoriteEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteEntity.date, ascending: false)])
    var favs: FetchedResults<FavoriteEntity>

    var body: some View {
        VStack {
            List {
                ForEach(favs) { apod in
                    HStack {
                        WebImage(url: URL(string: apod.hdurl ?? ""))
                            .resizable()
                            .placeholder(Image("placeholder"))
                            .indicator(Indicator.progress)
                            .transition(.fade(duration: 0.5))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                        Text(apod.title ?? "")
                    }
                    
                }
            }
        }
    }
}

struct Favorite_Previews: PreviewProvider {
    static var previews: some View {
        Favorite()
    }
}
