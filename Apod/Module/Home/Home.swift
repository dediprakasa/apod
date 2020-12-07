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
            if self.presenter.loadingState {
                VStack {
                    Text("Loading boss")
                }
            } else {
                List {
                    ForEach(presenter.apods, id: \.id) { apod in
                        VStack {
                            ApodCell(apod: apod)
                                .frame(height: 280)
                            Text(apod.date)
                            Text(apod.id.uuidString)
                            
                        }
                        
                    }
                }
            }
        }
        .onAppear(perform: {
            self.presenter.getRangedApods()
        })
    }
}

struct Home_Previews: PreviewProvider {
    @ObservedObject var presenter: HomePresenter
//    var remote = RemoteDataSource()
    @State private var disposables = Set<AnyCancellable>()

    static var previews: some View {
        Home(presenter: AppContainer().homePresenter)
    }
}
