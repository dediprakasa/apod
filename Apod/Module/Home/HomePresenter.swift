//
//  HomePresenter.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/28/20.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var apods = [Apod]()
    @Published var errorMessage = ""
    @Published var loadingState = false
    
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getRangedApods() {
        loadingState = true
        homeUseCase.getWeeklyApod(from: "2020-10-10", to: "2020-10-17")
            .receive(on: RunLoop.main)
            .sink { promise in
                switch promise {
                case .failure:
                    self.errorMessage = String(describing: promise)
                case .finished:
                    self.loadingState = false
                }
            } receiveValue: { apods in
                self.apods = apods
            }.store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(for apod: Apod, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: apod),
            label: {
                /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/
            })
    }
    
}
//
//struct HomePresenter_Previews: PreviewProvider {
//    static var previews: some View {
//        Text("Hello")
//    }
//}
