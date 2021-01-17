//
//  ApodTransformer.swift
//  Weekly
//
//  Created by Dedi Prakasa on 1/16/21.
//

import Foundation
import Core
import CoreData

public struct ApodTransformer: Mapper {    
    
    public typealias Response = [ApodResponse]
    
    public typealias Entity = [ApodEntityModule]
    
    public typealias Domain = [ApodDomainModel]
    
    private var context: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func transformResponsesToEntities(responses: [ApodResponse]) -> [ApodEntityModule] {
        return responses.map { response in
            let apodEntity = ApodEntityModule(context: context)
            apodEntity.id = UUID()
            apodEntity.apodSite = response.apodSite
            apodEntity.copyright = response.copyright
            apodEntity.date = response.date
            apodEntity.itemDescription = response.itemDescription
            apodEntity.hdurl = response.hdurl
            apodEntity.mediaType = response.mediaType
            apodEntity.title = response.title 
            apodEntity.url = response.url 

            return apodEntity
        }
    }
    
    public func transformEntitiesToDomains(entities: [ApodEntityModule]) -> [ApodDomainModel] {
        return entities.map { apod in
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
