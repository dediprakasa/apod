//
//  GetWeeklyLocaleDataSource.swift
//  Weekly
//
//  Created by Dedi Prakasa on 1/16/21.
//

import Foundation
import Core
import Combine
import CoreData

public struct GetWeeklyLocaleDataSource: LocalDataSource {
    
    public typealias Request = Any
    public typealias Response = ApodEntityModule
    
    private let context: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }

    public func list(request: Any?) -> AnyPublisher<[ApodEntityModule], Error> {
        let fetchRequest = NSFetchRequest<ApodEntityModule>(entityName: "ApodEntityModule")
        return Future<[ApodEntityModule], Error> { [self] completion in
            var apodEntities = [ApodEntityModule]()
            print(context, "==================================")
            context.perform {
                do {
                    print("XXX==================================")
                    apodEntities = try context.fetch(fetchRequest)
                    print("OOOOOO==================================")
                    completion(.success(apodEntities))
                } catch let error as NSError {
                    print("Could not fetch. \(error), \(error.userInfo)")
                    completion(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    private func batchInsertRequest(with apods: [ApodEntityModule]) -> NSBatchInsertRequest {
            var index = 0
            let total = apods.count
            let batchInsert = NSBatchInsertRequest(entity: ApodEntityModule.entity()) { (managedObject: NSManagedObject)
                -> Bool in
                guard index < total else { return true }
                if let apod = managedObject as? ApodEntityModule {
                    let data = apods[index]
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
    
    public func add(entities: [ApodEntityModule]) -> AnyPublisher<[ApodEntityModule], Error> {
        return Future<[ApodEntityModule], Error> { completion in
            guard !entities.isEmpty else { return }
            context.perform {
                let batchInsert = self.batchInsertRequest(with: entities)
                do {
                    try context.execute(batchInsert)
                    completion(.success(entities))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    public func get(id: String) -> AnyPublisher<ApodEntityModule, Error> {
        fatalError()
    }

    public func update(id: Int, entity: ApodEntityModule) -> AnyPublisher<Any, Error> {
        fatalError()
    }
}
