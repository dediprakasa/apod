//
//  WeeklyDomainModel.swift
//  Weekly
//
//  Created by Dedi Prakasa on 2/2/21.
//

import Foundation

public struct WeeklyDomainModel: Equatable, Identifiable {
    // swiftlint:disable:next variable_name
    public var id: UUID

    public let apodSite: String
    public let copyright: String
    public let date: String
    public let itemDescription: String
    public let hdurl: String
    public let mediaType: String
    public let title: String
    public let url: String
}
