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
    private let router: HomeRouter
    private let homeUseCase: HomeUseCase

    @Published var apods: [Apod] = []
    @Published var errorMessage = ""
    @Published var loadingState = false

    private var startDate: String {
        let date = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.string(from: date)
    }

    private var endDate: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.string(from: date)
    }

    init(useCase: HomeUseCase, router: HomeRouter) {
        self.homeUseCase = useCase
        self.router = router
    }

    func getRangedApods() {
        loadingState = true
        homeUseCase.getWeeklyApod(from: startDate, to: endDate)
            .receive(on: RunLoop.main)
            .sink { promise in
                switch promise {
                case .failure:
                    self.errorMessage = String(describing: promise)
                    print(self.errorMessage)
                case .finished:
                    self.loadingState = false
                }
            } receiveValue: { apods in
                DispatchQueue.main.async {
                    self.apods = apods
                }
            }.store(in: &cancellables)
    }

//    func linkBuilder<Content: View>(for apod: Apod, @ViewBuilder content: () -> Content) -> some View {
//        NavigationLink(
//            destination: router.makeDetailView(for: apod)) {
//            content()
//        }
//    }
}
