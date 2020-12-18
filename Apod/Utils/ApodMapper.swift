//
//  ApodMapper.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/23/20.
//

import Foundation

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

    static func mapApodEntitiesToDomains(from apodResponse: [WeeklyApods]) -> [Apod] {

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

    static func mapApodResponsesToEntities(from apodResponse: [ApodResponse]) -> [WeeklyApods] {

        return apodResponse.map { apod in
            let apodEntity = WeeklyApods(context: PersistenceController.shared.container.viewContext)
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
}
