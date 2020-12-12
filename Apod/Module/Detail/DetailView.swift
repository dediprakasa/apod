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
        ScrollView {
            WebImage(url: URL(string: presenter.apod?.hdurl ?? ""))
                .resizable()
                .placeholder(Image("placeholder"))
                .indicator(Indicator.progress)
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 200)

            Text(presenter.apod?.title ?? "")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            Text(presenter.apod?.itemDescription ?? "No description available")
                .padding(.horizontal)

            Spacer()
        }
        .onAppear(perform: {
            self.presenter.getApod()
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            Image("image_sample")
                .resizable()
                .frame(width: .infinity, height: 300)
                .scaledToFit()
            
            Text("Beautiful Universe")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                .padding(.horizontal)
            
            Spacer()
        }
    }
}
