//
//  LoadingView.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/22/20.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image("loading")
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
            Text("Loading...")
                .font(.title)
                .bold()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
