//
//  File.swift
//  
//
//  Created by Dedi Prakasa on 1/11/21.
//

import Foundation
import Core

public struct ApodTransformer: Mapper {
    public typealias Response = [ApodResponse]
    public typealias Entity = [ApodModuleEntity]
    public typealias Domain = [ApodDomainModel]

    public init() {}

    public func transformResponseToEntity(response: [ApodResponse]) -> [ApodModuleEntity] {
        return response.map { apod in
            let apodModuleEntity = ApodModuleEntity()
            apodModuleEntity.id = UUID()
            apodModuleEntity.apodSite = apod.apodSite ?? ""
            apodModuleEntity.copyright = apod.copyright ?? ""
            apodModuleEntity.date = apod.date ?? ""
            apodModuleEntity.itemDescription = apod.itemDescription ?? ""
            apodModuleEntity.hdurl = apod.hdurl ?? ""
            apodModuleEntity.mediaType = apod.mediaType ?? ""
            apodModuleEntity.title = apod.title ?? ""
            apodModuleEntity.url = apod.url ?? ""

            return apodModuleEntity
        }
    }

    public func transformEntityToDomain(entity: [ApodModuleEntity]) -> [ApodDomainModel] {
        return entity.map { apod in
          return ApodDomainModel(
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
}
