//
//  ApodMapper.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/23/20.
//

import Foundation
import Weekly

final class ApodMapper {

    static func mapApodResponsesToDomains(from apodResponse: [ApodResponse]) -> [Apod] {

      return apodResponse.map { apod in
        return Apod(
            id: UUID(),
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

    static func mapApodEntitiesToDomains(from apodResponse: [ApodEntityModule]) -> [Apod] {

      return apodResponse.map { apod in
        return Apod(
            id: apod.id ?? UUID(),
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

    static func mapApodResponsesToEntities(from apodResponse: [ApodResponse]) -> [ApodEntityModule] {

        return apodResponse.map { apod in
            let apodEntity = ApodEntityModule(context: Database.shared.context)
            apodEntity.id = UUID()
            apodEntity.apodSite = apod.apodSite ?? ""
            apodEntity.copyright = apod.copyright ?? ""
            apodEntity.date = apod.date ?? ""
            apodEntity.itemDescription = apod.itemDescription ?? ""
            apodEntity.hdurl = apod.hdurl ?? ""
            apodEntity.mediaType = apod.mediaType ?? ""
            apodEntity.title = apod.title ?? ""
            apodEntity.url = apod.url ?? ""

            return apodEntity
        }
    }

    static func mapFavoriteEntityToApod(from favorite: FavoriteEntity) -> Apod {
        return Apod(
            id: favorite.id ?? UUID(),
            apodSite: favorite.apodSite ?? "",
            copyright: favorite.copyright ?? "",
            date: favorite.date ?? "",
            itemDescription: favorite.itemDescription ?? "",
            hdurl: favorite.hdurl ?? "",
            mediaType: favorite.mediaType ?? "",
            title: favorite.title ?? "",
            url: favorite.url ?? "")
    }
}
