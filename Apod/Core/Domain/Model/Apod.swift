//
//  Apod.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/14/20.
//

import Foundation

struct Apod: Equatable, Identifiable {
    var id: UUID
    
    let apodSite: String
    let copyright: String
    let date: String
    let itemDescription: String
    let hdurl: String
    let mediaType: String
    let title: String
    let url: String
}
