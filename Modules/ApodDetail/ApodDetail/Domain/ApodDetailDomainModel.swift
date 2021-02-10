//
//  ApodDetailDomainModel.swift
//  ApodDetail
//
//  Created by Dedi Prakasa on 2/4/21.
//

import Foundation

public struct ApodDetailDomainModel: Equatable, Identifiable {
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

    public init(
        id: UUID,
        apodSite: String,
        copyright: String,
        date: String,
        itemDescription: String,
        hdurl: String,
        mediaType: String,
        title: String,
        url: String
    ) {
        self.id = id
        self.apodSite = apodSite
        self.copyright = copyright
        self.date = date
        self.itemDescription = itemDescription
        self.hdurl = hdurl
        self.mediaType = mediaType
        self.title = title
        self.url = url
    }
}
