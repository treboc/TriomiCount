//
//  CoreDataManager.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 03.02.22.
//

import CoreData

enum StorageType {
  case persistent, inMemory
}

class CoreDataManager {
  private(set) static var shared = CoreDataManager()

  var persistentContainer: NSPersistentContainer
  let context: NSManagedObjectContext

  init(_ storageType: StorageType = .persistent) {
    persistentContainer = NSPersistentContainer(name: "TriomiCount")

    let description = NSPersistentStoreDescription()
    if storageType == .inMemory {
      description.url = URL(fileURLWithPath: "/dev/null")
      description.shouldAddStoreAsynchronously = false
      self.persistentContainer.persistentStoreDescriptions = [description]
    } else {
      description.shouldAddStoreAsynchronously = true
    }

    persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

    context = persistentContainer.viewContext

    persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
      if let error = error as NSError? {
        fatalError("Unresolved loadPersistentStores error \(error), \(error.userInfo)")
      }
    })
  }

  func save(context: NSManagedObjectContext = shared.context) {
    if context.hasChanges {
      do {
        try context.save()
      } catch let error as NSError {
        context.rollback()
        NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
      }
    }
  }
}
