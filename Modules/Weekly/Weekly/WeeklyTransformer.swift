//
//  WeeklyTransformer.swift
//  Weekly
//
//  Created by Dedi Prakasa on 2/2/21.
//

import Foundation
import Core
import CoreData

public struct WeeklyTransformer: Mapper {
    public typealias Responses = [WeeklyApodResponse]
    public typealias Entities = [WeeklyModuleEntity]
    public typealias Domains = [WeeklyDomainModel]

    private let ctx: NSManagedObjectContext

    public init(context: NSManagedObjectContext) {
        self.ctx = context
    }

    public func transformResponseToEntity(responses: [WeeklyApodResponse]) -> [WeeklyModuleEntity] {
        return responses.map { apod in
            let apodEntity = WeeklyModuleEntity(context: ctx)
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

    public func transformEntityToDomain(entities: [WeeklyModuleEntity]) -> [WeeklyDomainModel] {
        return entities.map { apod in
            return WeeklyDomainModel(
                id: apod.id ?? UUID(),
                apodSite: apod.apodSite ?? "",
                copyright: apod.copyright ?? "",
                date: apod.date ?? "",
                itemDescription: apod.itemDescription ?? "",
                hdurl: apod.hdurl ?? "",
                mediaType: apod.mediaType ?? "",
                title: apod.title ?? "",
                url: apod.url ?? ""
            )
        }
    }
}
