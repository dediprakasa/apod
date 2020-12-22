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
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
