//
//  EmptyView.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/22/20.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image("empty")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150, alignment: .center)
            Text("You have no favorite yet")
                .font(.title)
                .bold()
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
