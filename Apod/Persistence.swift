//
//  Persistence.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/14/20.
//

import CoreData
import Weekly

class PersistentContainer: NSPersistentContainer { }

class PersistenceController {
    static let shared = PersistenceController()

    var container: NSPersistentContainer
    var context: NSManagedObjectContext {
        return container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ApodEntity")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
//            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }

    func prepareDatabase() {
        let modelBundles: [Bundle] = [
            Bundle(for: WeeklyModuleEntity.self)
        ]
        PersistenceController.shared.prepare(loadFromBundles: modelBundles)
    }

    func prepare(loadFromBundles bundles: [Bundle]?) {
        let model = NSManagedObjectModel.mergedModel(from: bundles)!
        container = PersistentContainer(name: "Database", managedObjectModel: model)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Unresolved error \(error)")
                fatalError()
            }
        }

        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
    }
}
