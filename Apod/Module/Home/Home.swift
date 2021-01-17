//
//  ContentView.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/14/20.
//

import SwiftUI
import CoreData
import Combine
import Weekly
import Core

struct Home: View {

    @ObservedObject var presenter: GetListPresenter<
        (startDate: String, endDate: String),
        ApodDomainModel,
        Interactor<
            (startDate: String, endDate: String),
            [ApodDomainModel],
            GetWeeklyRepository<
            GetWeeklyLocaleDataSource,
            GetWeeklyRemoteDataSource,
            ApodTransformer
            >
        >>
    @State private var disposables = Set<AnyCancellable>()
//    @EnvironmentObject var db: Database

    @FetchRequest(entity: ApodEntityModule.entity(), sortDescriptors: [])
    var tes: FetchedResults<ApodEntityModule> {
        didSet {
            print(tes.count)
        }
    }

    var body: some View {
        ZStack {
            if self.presenter.isLoading {
                VStack {
                    LoadingView()
                }
            } else {
                NavigationView {
                    List {
                        ForEach(self.presenter.list, id: \.id) { apod in
                            linkBuilder(for: apod) {
                                ApodCell(apod: apod)
                                    .frame(height: 280)
                            }
                            
                        }
                    }
                    .navigationBarTitle("Pictures of The Week", displayMode: .automatic)
                }
            }
        }
        .onAppear(perform: {
            self.presenter.execute(request: nil)
        })
    }
    
    func linkBuilder<Content: View>(for apod: ApodDomainModel, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(
            destination: HomeRouter.makeDetailView(for: apod)) {
            content()
        }
    }
}
