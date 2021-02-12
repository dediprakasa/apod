//
//  GetWeeklyLocaleDataSource.swift
//  Weekly
//
//  Created by Dedi Prakasa on 2/2/21.
//

import Foundation
import Core
import CoreData
import Combine

public struct GetWeeklyLocaleDataSource: LocaleDataSource {
    public typealias Request = Any
    public typealias Response = WeeklyModuleEntity

    private let ctx: NSManagedObjectContext
    public init(context: NSManagedObjectContext) {
        ctx = context
    }

    private func batchInsertRequest(with apods: [WeeklyModuleEntity]) -> NSBatchInsertRequest {
        var index = 0
        let total = apods.count
        let batchInsert = NSBatchInsertRequest(
            entity: WeeklyModuleEntity.entity()) { (managedObject: NSManagedObject) -> Bool in
            guard index < total else { return true }
            let data = apods[index]
            if let apod = managedObject as? WeeklyModuleEntity {
                apod.id = data.id
                apod.apodSite = data.apodSite
                apod.copyright = data.copyright
                apod.date = data.date
                apod.itemDescription = data.itemDescription
                apod.hdurl = data.hdurl
                apod.mediaType = data.mediaType
                apod.title = data.title
                apod.url = data.url
            }
            index += 1
            return false
        }
        return batchInsert
    }

    public func list(request: Any?) -> AnyPublisher<[WeeklyModuleEntity], Error> {
        let fetchRequest = NSFetchRequest<WeeklyModuleEntity>(entityName: "WeeklyModuleEntity")
        return Future<[WeeklyModuleEntity], Error> {[self] completion in
            var apodEntities = [WeeklyModuleEntity]()
            ctx.perform {
                do {
                    apodEntities = try ctx.fetch(fetchRequest)
                    completion(.success(apodEntities))
                } catch let error as NSError {
                    print("Could not fetch. \(error), \(error.userInfo)")
                    completion(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    public func add(entities: [WeeklyModuleEntity]) -> AnyPublisher<[WeeklyModuleEntity], Error> {
        return Future<[WeeklyModuleEntity], Error> { completion in
            guard !entities.isEmpty else { return }
            let batchInsert = self.batchInsertRequest(with: entities)
            do {
                try ctx.execute(batchInsert)
                completion(.success(entities))
            } catch {
                completion(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
