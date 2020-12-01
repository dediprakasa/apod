//
//  ContentView.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/14/20.
//

import SwiftUI
import CoreData
import Combine

struct Home: View {

    @ObservedObject var presenter: HomePresenter
//    var remote = RemoteDataSource()
    @State private var disposables = Set<AnyCancellable>()
    @State var teks = ""

    var body: some View {
        ZStack {
            Image("image_sample")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 2)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 10)
                .frame(width: 200, height: 200, alignment: .center)
            
            Text("")
                .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.clear)
                .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .clipShape(Rectangle())
                .onAppear(perform: {
                    print("Opened")
                })
            
            Text("aasaa")
        }
            
        
    }
}

struct Home_Previews: PreviewProvider {
    @ObservedObject var presenter: HomePresenter
//    var remote = RemoteDataSource()
    @State private var disposables = Set<AnyCancellable>()
    @State var teks = ""
    static var previews: some View {
        Home(presenter: AppContainer().homePresenter)
    }
}
