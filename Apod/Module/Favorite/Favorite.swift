//
//  Favorite.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/3/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct Favorite: View {

    @ObservedObject var presenter: FavoritePresenter

    var body: some View {
        NavigationView {
            List {
                ForEach(self.presenter.favorites) { apod in
                    self.presenter.linkBuilder(for: apod) {
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
            .navigationBarTitle("Favorite", displayMode: .inline)
        }
        .onAppear(perform: {
            self.presenter.getFavorites()
        })
    }
}
