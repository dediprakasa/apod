//
//  ApodDetailTransformer.swift
//  ApodDetail
//
//  Created by Dedi Prakasa on 2/6/21.
//

import Foundation
import Core
import CoreData

public struct ApodDetailTransformer: Mapper {
    public typealias Responses = [ApodDetailResponse]

    public typealias Entities = [ApodDetailModuleEntity]
    public typealias Domains = [ApodDetailDomainModel]

    private let ctx: NSManagedObjectContext

    public init(context: NSManagedObjectContext) {
        self.ctx = context
    }

    public func transformResponseToEntity(responses: [ApodDetailResponse]) -> [ApodDetailModuleEntity] {
        return responses.map { apod in
            let apodEntity = ApodDetailModuleEntity(context: ctx)
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

    public func transformEntityToDomain(entities: [ApodDetailModuleEntity]) -> [ApodDetailDomainModel] {
        return entities.map { apod in
            return ApodDetailDomainModel(
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
