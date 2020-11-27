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

    var remote = RemoteDataSource(apodFetcher: ApodFetcher())
    @State private var disposables = Set<AnyCancellable>()
    
    
    var body: some View {
        Text("Hello")
            .onAppear(perform: {
                print("=====")
                DispatchQueue.main.async {
                    self.remote.getRangedApods(from: "2020-10-01", to: "2020-11-10")
                        .print("1111")
                        .sink { _ in
                            
                        } receiveValue: { response in
                            print(response, "!!!!")
                        }
                        .store(in: &disposables)

                }
                
                    

            })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
