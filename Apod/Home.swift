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
        Text("Halo")
            .onAppear(perform: {
                print("Opened")
            })
    }
}


//struct ContentView_Previews: PreviewProvider {
//    @ObservedObject var presenter: HomePresenter
//    static var previews: some View {
//        Home(presenter: presenter).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
