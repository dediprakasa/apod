//
//  ApodEntityModule+CoreDataProperties.swift
//  
//
//  Created by Dedi Prakasa on 1/13/21.
//
//

import Foundation
import CoreData


extension ApodEntityModule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ApodEntityModule> {
        return NSFetchRequest<ApodEntityModule>(entityName: "ApodEntityModule")
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
