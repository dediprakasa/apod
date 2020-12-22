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
                .frame(width: 100, height: 100, alignment: .center)
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
