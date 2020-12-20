//
//  DetailView.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/29/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {

    @ObservedObject var presenter: DetailPresenter

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                WebImage(url: URL(string: presenter.apod.hdurl))
                    .resizable()
                    .placeholder(Image("placeholder"))
                    .indicator(Indicator.progress)
                    .transition(.fade(duration: 0.5))
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300, alignment: .center)
                    .frame(maxWidth: .infinity)

                Text(presenter.apod.title)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
    
                Text(presenter.apod.itemDescription)
                    .padding(.horizontal)

                Spacer()
            }
        }
        .navigationBarTitle(self.presenter.apod.date, displayMode: .inline)
        .navigationBarItems(trailing:
            Image(systemName: self.presenter.isFavorite ? "bookmark.fill" : "bookmark")
            .onTapGesture { self.presenter.updateFavorite()}
        )
    }
}
