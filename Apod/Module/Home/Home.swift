//
//  ContentView.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/14/20.
//

import SwiftUI
import CoreData
import Combine
import Core
import Weekly

struct Home: View {

    @ObservedObject var presenter: GetListPresenter<(startDate: String, endDate: String), WeeklyDomainModel, Interactor<(startDate: String, endDate: String), [WeeklyDomainModel], GetWeeklyRepository<GetWeeklyLocaleDataSource, GetWeeklyRemoteDataSource, WeeklyTransformer>>>
    @State private var disposables = Set<AnyCancellable>()

    var body: some View {
        ZStack {
            if self.presenter.isLoading {
                VStack {
                    LoadingView()
                }
            } else {
                NavigationView {
                    List {
                        ForEach(presenter.list, id: \.id) { apod in
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
            self.presenter.getList()
        })
    }

    func linkBuilder<Content: View>(for apod: WeeklyDomainModel, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: apod)) {
            content()
        }
    }
}
