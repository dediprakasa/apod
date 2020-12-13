//
//  LocalDataSource.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/5/20.
//

import Foundation
import Combine
import CoreData

protocol LocalDataSourceProtocol {

    func addWeeklyApods(from apods: [ApodEntity]) -> AnyPublisher<[ApodEntity], Error>
    func getApods() -> AnyPublisher<[ApodEntity], Error>
}

class LocalDataSource: NSObject {
    static let sharedInstance = LocalDataSource()
    private override init() { }
    let container = PersistenceController.shared.container
    let managedObjectContext = PersistenceController.shared.container.viewContext
}

extension LocalDataSource: LocalDataSourceProtocol {
    private func batchInsertRequest(with apods: [ApodEntity]) -> NSBatchInsertRequest {
        var index = 0
        let total = apods.count
        let batchInsert = NSBatchInsertRequest(entity: ApodEntity.entity()) { (managedObject: NSManagedObject) -> Bool in
            guard index < total else { return true }
            if let apod = managedObject as? ApodEntity {
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

    func addWeeklyApods(from apods: [ApodEntity]) -> AnyPublisher<[ApodEntity], Error> {

        return Future<[ApodEntity], Error> { completion in

            guard !apods.isEmpty else { return }

            self.container.performBackgroundTask { context in
                let batchInsert = self.batchInsertRequest(with: apods)
                do {
                    try context.execute(batchInsert)
                    completion(.success(apods))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func getApods() -> AnyPublisher<[ApodEntity], Error> {
        let fetchRequest = NSFetchRequest<ApodEntity>(entityName: "ApodEntity")
        return Future<[ApodEntity], Error> { [self] completion in
            var apodEntities = [ApodEntity]()
            let moc = container.viewContext
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
    
//    func updateFavoriteApods() -> AnyPublisher<Bool, Error> {
//        
//    }
}
