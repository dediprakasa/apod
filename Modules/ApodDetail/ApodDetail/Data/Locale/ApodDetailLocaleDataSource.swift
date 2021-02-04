//
//  ApodDetailLocaleDataSource.swift
//  ApodDetail
//
//  Created by Dedi Prakasa on 2/4/21.
//

import Foundation
import Core
import Combine
import CoreData

public struct ApodDetailLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    public typealias Response = ApodDetailModuleEntity
    
    private let ctx: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        ctx = context
    }
    
    public func list(request: Any?) -> AnyPublisher<[ApodDetailModuleEntity], Error> {
        let fetchRequest = NSFetchRequest<ApodDetailModuleEntity>(entityName: "ApodDetailModuleEntity")
        return Future<[ApodDetailModuleEntity], Error> {[self] completion in
            var apodEntities = [ApodDetailModuleEntity]()
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
    
    public func add(entities: [ApodDetailModuleEntity]) -> AnyPublisher<[ApodDetailModuleEntity], Error> {
        return Future<[ApodDetailModuleEntity], Error> { completion in
            guard !entities.isEmpty else { return }
            
            guard let apodEntity = NSEntityDescription.entity(forEntityName: "ApodDetailModuleEntity", in: ctx) else { return }
            
            let apod = NSManagedObject.init(entity: apodEntity, insertInto: ctx)
            apod.setValue(entities[0].apodSite, forKey: "apodSite")
            apod.setValue(entities[0].copyright, forKey: "copyright")
            apod.setValue(entities[0].date, forKey: "date")
            apod.setValue(entities[0].hdurl, forKey: "hdurl")
            apod.setValue(entities[0].id, forKey: "id")
            apod.setValue(entities[0].itemDescription, forKey: "itemDescription")
            apod.setValue(entities[0].mediaType, forKey: "mediaType")
            apod.setValue(entities[0].title, forKey: "title")
            apod.setValue(entities[0].url, forKey: "url")
            
            do {
                try ctx.save()
                completion(.success(entities))
            } catch {
                completion(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func get(id: String) -> AnyPublisher<ApodDetailModuleEntity, Error> {
        fatalError()
    }
    
    public func update(apod: Any) -> AnyPublisher<Bool, Error> {
        
        return Future<Bool, Error> { [self] completion in
            guard let apod = apod as? ApodDetailDomainModel else {
                return
            }
            let fetchRequest = NSFetchRequest<ApodDetailModuleEntity>(entityName: "ApodDetailModuleEntity")
            fetchRequest.predicate = NSPredicate(format: "id == %@", apod.date)
            var favorites = [ApodDetailModuleEntity]()
            do {
                favorites = try ctx.fetch(fetchRequest)
                if favorites.count != 0 {
                    ctx.delete(favorites[0])
                    completion(.success(false))
                } else {
                    let newFavorite = ApodDetailModuleEntity(context: ctx)
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

                try ctx.save()
                completion(.success(true))

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
