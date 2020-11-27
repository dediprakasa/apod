//
//  ApodsResponse.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/23/20.
//

import Foundation

struct ApodsResponse: Decodable {
    let apods: [ApodResponse]
}

struct ApodResponse: Decodable {
    let apodSite: String?
    let copyright: String?
    let date: String?
    let itemDescription: String?
    let hdurl: String?
    let mediaType: String?
    let title: String?
    let url: String?
    
    private enum CodingKeys: String, CodingKey {
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
