//
//  Favorite.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/3/20.
//

import SwiftUI
import Core
import ApodDetail
import SDWebImageSwiftUI

struct Favorite: View {

    @ObservedObject var presenter: ApodFavoritePresenter<
        Interactor
            <
            Any,
            [ApodDetailDomainModel],
            GetFavoriteRepository
                <
                    ApodDetailLocaleDataSource,
                    ApodDetailRemoteDataSource,
                    ApodDetailTransformer
                >
            >>

    var body: some View {
        NavigationView {
            if self.presenter.favorites.isEmpty {
                EmptyView()
            } else {
                List {
                    ForEach(self.presenter.favorites) { apod in
                        linkBuilder(for: apod) {
                            HStack {
                                WebImage(url: URL(string: apod.hdurl))
                                    .resizable()
                                    .placeholder(Image("placeholder"))
                                    .indicator(Indicator.progress)
                                    .transition(.fade(duration: 0.5))
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                                Text(apod.title)
                            }
                        }
                    }
                }
                .navigationBarTitle("Favorite", displayMode: .inline)
            }
        }
        .onAppear(perform: {
            self.presenter.getFavorites()
        })
    }

    func linkBuilder<Content: View>(for apod: ApodDetailDomainModel, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(
            destination: FavoriteRouter().makeDetailView(for: apod, withFavoritePresenter: presenter)) {
            content()
        }
    }
}
