//
//  GetWeeklyLocaleDataSource.swift
//  
//
//  Created by Dedi Prakasa on 1/8/21.
//

import Foundation
import Core
import CoreData
import Combine

public struct GetWeeklyLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    public typealias Response = ApodModuleEntity
    private let _container: NSPersistentContainer

    public init(container: NSPersistentContainer) {
        _container = container
    }
    
    public func list(request: Any?) -> AnyPublisher<[ApodModuleEntity], Error> {
        let fetchRequest = NSFetchRequest<ApodModuleEntity>(entityName: "ApodModuleEntity")
        return Future<[ApodModuleEntity], Error> { [self] completion in
            var apodEntities = [ApodModuleEntity]()
            let moc = _container.viewContext
            moc.perform {
                do {
                    apodEntities = try moc.fetch(fetchRequest)
                    completion(.success(apodEntities))
                } catch let error as NSError {
                  print("Could not fetch. \(error), \(error.userInfo)")
                  completion(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    public func add(entities: [ApodModuleEntity]) -> AnyPublisher<[ApodModuleEntity], Error> {
        return Future<[ApodModuleEntity], Error> { completion in
            guard !entities.isEmpty else { return }
            _container.performBackgroundTask { context in
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

    public func get(id: String) -> AnyPublisher<ApodModuleEntity, Error> {
        fatalError()
    }

    public func update(id: Int, entity: ApodModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }

    private func batchInsertRequest(with apods: [ApodModuleEntity]) -> NSBatchInsertRequest {
        var index = 0
        let total = apods.count
        let batchInsert = NSBatchInsertRequest(entity: ApodModuleEntity.entity()) { (managedObject: NSManagedObject)
            -> Bool in
            guard index < total else { return true }
            if let apod = managedObject as? ApodModuleEntity {
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

    public func list() -> AnyPublisher<[ApodModuleEntity], Error> {
        let fetchRequest = NSFetchRequest<ApodModuleEntity>(entityName: "ApodModuleEntity")
        return Future<[ApodModuleEntity], Error> { [self] completion in
            var apodEntities = [ApodModuleEntity]()
            let moc = _container.viewContext
            moc.perform {
                do {
                    apodEntities = try moc.fetch(fetchRequest)
                    completion(.success(apodEntities))
                } catch let error as NSError {
                  print("Could not fetch. \(error), \(error.userInfo)")
                  completion(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
