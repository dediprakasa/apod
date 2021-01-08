//
//  GetWeeklyLocaleDataSource.swift
//  
//
//  Created by Dedi Prakasa on 1/8/21.
//

import Foundation
import Core
import CoreData
import Combine

public struct GetWeeklyLocaleDataSource: LocaleDataSource {
    public typealias Request = Any
    public typealias Response = ApodEntity
}

