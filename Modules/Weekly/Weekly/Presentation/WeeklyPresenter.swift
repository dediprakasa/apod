//
//  WeeklyPresentation.swift
//  Weekly
//
//  Created by Dedi Prakasa on 2/12/21.
//

import Foundation
import SwiftUI
import Combine
import Core

public class WeeklyPresenter<WeeklyUseCase: UseCase>: ObservableObject
where WeeklyUseCase.Request == (startDate: String, endDate: String),
      WeeklyUseCase.Response == [WeeklyDomainModel] {

    private var cancellables: Set<AnyCancellable> = []
    private var weeklyUseCase: WeeklyUseCase

    @Published public var apods: [WeeklyDomainModel] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(weeklyUseCase: WeeklyUseCase) {
        self.weeklyUseCase = weeklyUseCase
    }

    public func getWeeklyList() {
        weeklyUseCase.execute(request: nil)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { apods in
                self.apods = apods
            })
            .store(in: &cancellables)
    }
}
