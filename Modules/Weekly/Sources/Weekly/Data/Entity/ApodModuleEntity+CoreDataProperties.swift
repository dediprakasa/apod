//
//  ApodModuleEntity+CoreDataProperties.swift
//  Apod
//
//  Created by Dedi Prakasa on 1/10/21.
//
//

import Foundation
import CoreData


extension ApodModuleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ApodModuleEntity> {
        return NSFetchRequest<ApodModuleEntity>(entityName: "ApodModuleEntity")
    }

    @NSManaged public var apodSite: String?
    @NSManaged public var copyright: String?
    @NSManaged public var date: String?
    @NSManaged public var hdurl: String?
    @NSManaged public var id: UUID?
    @NSManaged public var itemDesription: String?
    @NSManaged public var mediaType: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
