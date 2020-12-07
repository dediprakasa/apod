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

    func addWeeklyApods(from apods: [ApodEntity]) -> AnyPublisher<Bool, Error>
    func getApods() -> AnyPublisher<[ApodEntity], Error>
}

class LocalDataSource: NSObject {
    static let sharedInstance = LocalDataSource()
    private override init() { }
    let managedObjectContext = PersistenceController.shared.container.viewContext
}

extension LocalDataSource: LocalDataSourceProtocol {
    func addWeeklyApods(from apods: [ApodEntity]) -> AnyPublisher<Bool, Error> {
        let apodEntity = ApodEntity(context: self.managedObjectContext)
        return Future<Bool, Error> { completion in
            self.managedObjectContext.perform {
                for apod in apods {

                        apodEntity.id = apod.id
                        apodEntity.apodSite = apod.apodSite
                        apodEntity.copyright = apod.copyright
                        apodEntity.date = apod.date
                        apodEntity.itemDescription = apod.itemDescription
                        apodEntity.hdurl = apod.hdurl
                        apodEntity.mediaType = apod.mediaType
                        apodEntity.title = apod.title
                        apodEntity.url = apod.url

                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            completion(.failure(error))
                        }
                }
                print("number of saved: \(apods.count)")
                completion(.success(true))
            }
        }
        .eraseToAnyPublisher()
    }

    func getApods() -> AnyPublisher<[ApodEntity], Error> {
        let fetchRequest = NSFetchRequest<ApodEntity>(entityName: "ApodEntity")
        return Future<[ApodEntity], Error> { completion in
            var apodEntities = [ApodEntity]()
            self.managedObjectContext.perform {
                do {
                    apodEntities = try self.managedObjectContext.fetch(fetchRequest)
                    print("number of fetched: \(apodEntities.count)")
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
