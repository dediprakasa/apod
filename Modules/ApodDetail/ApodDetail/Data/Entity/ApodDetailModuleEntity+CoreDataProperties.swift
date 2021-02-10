//
//  ApodDetailModuleEntity+CoreDataProperties.swift
//  ApodDetail
//
//  Created by Dedi Prakasa on 2/4/21.
//
//

import Foundation
import CoreData

extension ApodDetailModuleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ApodDetailModuleEntity> {
        return NSFetchRequest<ApodDetailModuleEntity>(entityName: "ApodDetailModuleEntity")
    }

    @NSManaged public var apodSite: String?
    @NSManaged public var copyright: String?
    @NSManaged public var date: String?
    @NSManaged public var hdurl: String?
    @NSManaged public var id: UUID?
    @NSManaged public var itemDescription: String?
    @NSManaged public var mediaType: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}

extension ApodDetailModuleEntity: Identifiable {

}
