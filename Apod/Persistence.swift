//
//  Persistence.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/14/20.
//

import CoreData
import Weekly
import ApodDetail

class PersistentContainer: NSPersistentContainer { }

class PersistenceController {
    static let shared = PersistenceController()

    var container: NSPersistentContainer
    var context: NSManagedObjectContext {
        return container.viewContext
    }

    private init(inMemory: Bool = false) {
        let modelBundles: [Bundle] = [
            Bundle(for: WeeklyModuleEntity.self),
            Bundle(for: ApodDetailModuleEntity.self)
        ]
        let model = NSManagedObjectModel.mergedModel(from: modelBundles)!
        container = PersistentContainer(name: "Database", managedObjectModel: model)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
    }

//    func prepareDatabase() {
//        let modelBundles: [Bundle] = [
//            Bundle(for: WeeklyModuleEntity.self),
//            Bundle(for: ApodDetailModuleEntity.self)
//        ]
//        PersistenceController.shared.prepare(loadFromBundles: modelBundles)
//    }

//    func prepare(loadFromBundles bundles: [Bundle]?) {
//        let model = NSManagedObjectModel.mergedModel(from: bundles)!
//        container.loadPersistentStores { _, error in
//            if let error = error {
//                print("Unresolved error \(error)")
//                fatalError()
//            }
//        }
//
//        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//        context.automaticallyMergesChangesFromParent = true
//    }
}
