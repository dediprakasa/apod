//
//  File.swift
//  
//
//  Created by Dedi Prakasa on 1/10/21.
//

import Foundation

public struct ApodDomainModel: Equatable, Identifiable {
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
