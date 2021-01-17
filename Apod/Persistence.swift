//
//  Persistence.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/14/20.
//

import CoreData
import Weekly

class PersistenceController {
    static let shared = PersistenceController()

//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = ApodEntity(context: viewContext)
//            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()

    let container: NSPersistentContainer

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
}

class PersistentContainer: NSPersistentContainer { }

class Database: ObservableObject {
    static let shared = Database()
    var persistentContainer: NSPersistentContainer!

    var context: NSManagedObjectContext {
        print(persistentContainer.viewContext, "<<<<<<")
        return persistentContainer.viewContext
    }

    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(backgroundContextDidSave(notification:)), name: .NSManagedObjectContextDidSave, object: nil)
    }

    @objc func backgroundContextDidSave(notification: Notification) {
        guard let notificationContext = notification.object as? NSManagedObjectContext else { return }

        guard notificationContext !== context else {
            return
        }

        context.perform {
            self.context.mergeChanges(fromContextDidSave: notification)
        }
    }

    func performBackgroundTask(block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
    
    lazy var managedObjectModel: NSManagedObjectModel = {
            // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
            let carKitBundle = Bundle(identifier: "com.deltadirac.Weekly")
        
        if carKitBundle == nil {
            print("whattttt")
        }
            
        let modelURL = carKitBundle!.url(forResource: "Model", withExtension: "momd")!
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to create model from file: \(modelURL)")
        }
            return mom
    }()

    func prepareDatabase() {
        
        let modelBundles: [Bundle] = [
            Bundle(identifier: "com.deltadirac.Weekly")!,
            Bundle.main
        ]
        Database.shared.prepare(loadFromBundles: modelBundles)
    }

    func prepare(loadFromBundles bundles: [Bundle]?) {
        let mom = NSManagedObjectModel.mergedModel(from: bundles)!
        persistentContainer = PersistentContainer(name: "Database", managedObjectModel: mom)
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Unresolved error \(error)")
                fatalError()
            }
        }

        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
    }

    func saveContext() {
        do {
            if persistentContainer.viewContext.hasChanges {
                try persistentContainer.viewContext.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
