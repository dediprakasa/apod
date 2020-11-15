//
//  Apod.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/14/20.
//

import Foundation

struct Apod {
    struct Item: Codable {
        let apodSite: String
        let copyright: String
        let date: String
        let itemDescription: String
        let hdurl: String
        let mediaType: String
        let title: String
        let url: String

        enum CodingKeys: String, CodingKey {
            case apodSite = "apod_site"
            case copyright
            case date
            case itemDescription = "description"
            case hdurl
            case mediaType = "media_type"
            case title
            case url
        }
    }
}
