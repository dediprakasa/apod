//
//  LocalDataSource.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/5/20.
//

import Foundation
import Combine
import CoreData
import Weekly

protocol LocalDataSourceProtocol {

    func addWeeklyApods(from apods: [ApodEntityModule]) -> AnyPublisher<[ApodEntityModule], Error>
    func getApods() -> AnyPublisher<[ApodEntityModule], Error>
    func updateFavorite(apod: Apod) -> AnyPublisher<Bool, Error>
    func checkFavorite(apod: Apod) -> AnyPublisher<Bool, Error>
    func getFavorites() -> AnyPublisher<[FavoriteEntity], Error>
}

class LocalDataSource: NSObject {
    static let sharedInstance = LocalDataSource()
    private override init() { }
    let container = Database.shared.persistentContainer
    let managedObjectContext = Database.shared.context
}

extension LocalDataSource: LocalDataSourceProtocol {
    private func batchInsertRequest(with apods: [ApodEntityModule]) -> NSBatchInsertRequest {
        var index = 0
        let total = apods.count
        let batchInsert = NSBatchInsertRequest(entity: ApodEntityModule.entity()) { (managedObject: NSManagedObject) -> Bool in
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

    func addWeeklyApods(from apods: [ApodEntityModule]) -> AnyPublisher<[ApodEntityModule], Error> {

        return Future<[ApodEntityModule], Error> { completion in

            guard !apods.isEmpty, let container = self.container else { return }

            container.performBackgroundTask { context in
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

    func getApods() -> AnyPublisher<[ApodEntityModule], Error> {
        let fetchRequest = NSFetchRequest<ApodEntityModule>(entityName: "ApodEntityModule")
        return Future<[ApodEntityModule], Error> { [self] completion in
            var apodEntities = [ApodEntityModule]()
            guard let container = self.container else { return }
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

    func updateFavorite(apod: Apod) -> AnyPublisher<Bool, Error> {
        let fetchRequest = NSFetchRequest<FavoriteEntity>(entityName: "FavoriteEntity")
        fetchRequest.predicate = NSPredicate(format: "date == %@", apod.date)
        return Future<Bool, Error> { [self] completion in
            var favorites = [FavoriteEntity]()
            guard let container = self.container else { return }
            let moc = container.viewContext
            do {
                favorites = try moc.fetch(fetchRequest)
                if favorites.count != 0 {
                    moc.delete(favorites[0])
                    completion(.success(false))
                } else {
                    let newFavorite = FavoriteEntity(context: moc)
                    newFavorite.id = apod.id
                    newFavorite.apodSite = apod.apodSite
                    newFavorite.copyright = apod.copyright
                    newFavorite.date = apod.date
                    newFavorite.itemDescription = apod.itemDescription
                    newFavorite.hdurl = apod.hdurl
                    newFavorite.mediaType = apod.mediaType
                    newFavorite.title = apod.title
                    newFavorite.url = apod.url
                }

                try moc.save()
                completion(.success(true))

            } catch {
                completion(.failure(LocalError.somethingWentWrong))
            }
        }
        .eraseToAnyPublisher()
    }

    func checkFavorite(apod: Apod) -> AnyPublisher<Bool, Error> {
        let fetchRequest = NSFetchRequest<FavoriteEntity>(entityName: "FavoriteEntity")
        fetchRequest.predicate = NSPredicate(format: "date == %@", apod.date)
        return Future<Bool, Error> { [self] completion in
            var favorites = [FavoriteEntity]()
            guard let container = self.container else { return }
            let moc = container.viewContext
            do {
                favorites = try moc.fetch(fetchRequest)
                if favorites.count != 0 {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            } catch {
                completion(.failure(LocalError.somethingWentWrong))
            }
        }
        .eraseToAnyPublisher()
    }

    func getFavorites() -> AnyPublisher<[FavoriteEntity], Error> {
        let fetchRequest = NSFetchRequest<FavoriteEntity>(entityName: "FavoriteEntity")
        return Future<[FavoriteEntity], Error> { [self] completion in
            var favorites = [FavoriteEntity]()
            guard let container = self.container else { return }
            let moc = container.viewContext
            do {
                favorites = try moc.fetch(fetchRequest)
                completion(.success(favorites))
            } catch {
                completion(.failure(LocalError.somethingWentWrong))
            }
        }
        .eraseToAnyPublisher()
    }
}

enum LocalError: Error {
    case notFound
    case somethingWentWrong
}
