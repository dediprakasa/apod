//
//  ApodMapper.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/23/20.
//

import Foundation

final class ApodMapper {

    static func mapToDomains(from apodResponse: [ApodResponse]) -> [Apod] {

      return apodResponse.map { apod in
        return Apod(
            apodSite: apod.apodSite ?? "",
            copyright: apod.copyright ?? "",
            date: apod.date ?? "",
            itemDescription: apod.itemDescription ?? "",
            hdurl: apod.hdurl ?? "",
            mediaType: apod.mediaType ?? "",
            title: apod.title ?? "",
            url: apod.url ?? "")
      }
    }
}
