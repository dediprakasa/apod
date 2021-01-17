//
//  ApodCell.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/2/20.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI
import Core
import Weekly

struct ApodCell: View {

    var apod: ApodDomainModel

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                WebImage(url: URL(string: apod.hdurl))
                    .resizable()
                    .placeholder(Image("placeholder"))
                    .indicator(Indicator.progress)
                    .transition(.fade(duration: 0.5))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .overlay(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .center, endPoint: .bottom))

                ZStack {

                    Text(self.apod.title)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 2, leading: 16, bottom: 4, trailing: 16))
                        .frame(width: geometry.size.width, alignment: .leading)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
    }
}

struct ApodCell_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
