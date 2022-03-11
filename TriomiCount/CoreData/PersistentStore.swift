//
//  PersistentStore.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 03.02.22.
//

import Foundation
import CoreData
import SwiftUI

final class PersistentStore: ObservableObject {
    private(set) static var shared = PersistentStore()
    
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "TriomiCount")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use
                // this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved loadPersistentStores error \(error), \(error.userInfo)")
            }
            
        })
    }
    
    static var preview: PersistentStore = {
        let result = PersistentStore(inMemory: true)
        let viewContext = result.context
        
        do {
            for i in 1...10 {
                let newPlayer = Player(name: "Player \(1)", position: Int16(i), context: viewContext)
            }
            
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
    
    func childViewContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = self.context
        return context
    }
    
    func newTemporaryInstance<T: NSManagedObject>(in context: NSManagedObjectContext) -> T {
        return T(context: context)
    }
    
    func copyForEditing<T: NSManagedObject>(of object: T,
                                            in context: NSManagedObjectContext) -> T {
        guard let object = (try? context.existingObject(with: object.objectID)) as? T else {
            fatalError("Requested copy of a managed object that doesn't exist.")
        }
        return object
    }
    
    func persist(_ object: NSManagedObject) {
        guard let objectContext = object.managedObjectContext else { return }
        do {
            try objectContext.save()
        } catch let error {
            print(error)
        }
        
        if let parent = objectContext.parent {
            do {
                try parent.save()
            } catch let error as NSError {
                print(error)
            }
        }
    }
}
