//
//  NSManagedObject+Extensions.swift
//  ShoppingList
//
//  Created by Jerry on 1/2/21.
//  Copyright © 2021 Jerry. All rights reserved.
//

import Foundation
import CoreData

// ideas below due to @Hatsushira and @NigelGee on the Hacking With Swift forums
// (something i wanted a while ago, but could never quite get the syntax right)

extension NSManagedObject {
  // makes it easy to count NSManagedObjects in a given context.  useful during
  // app development.
  class func countAllObjects<T: NSManagedObject>(ofType type: T, context: NSManagedObjectContext) -> Int {
    let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: T.description())
    do {
      let result = try context.count(for: fetchRequest)
      return result
    } catch let error as NSError {
      NSLog("Error counting NSManagedObjects \(Self.description()): \(error.localizedDescription), \(error.userInfo)")
    }
    return 0
  }

  // simple way to get all objects
  class func allObjects(context: NSManagedObjectContext) -> [NSManagedObject] {
    let fetchRequest: NSFetchRequest<Self> = NSFetchRequest<Self>(entityName: Self.description())
    do {
      let result = try context.fetch(fetchRequest)
      return result
    } catch let error as NSError {
      NSLog("Error fetching NSManagedObjects \(Self.description()): \(error.localizedDescription), \(error.userInfo)")
    }
    return []
  }

  // finds an NSManagedObject with the given UUID (there should only be one, really)
  class func object(id: UUID, context: NSManagedObjectContext) -> Self? {
    let fetchRequest: NSFetchRequest<Self> = NSFetchRequest<Self>(entityName: Self.description())
    fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    do {
      let results = try context.fetch(fetchRequest)
      return results.first
    } catch let error as NSError {
      NSLog("Error fetching NSManagedObjects \(Self.description()): \(error.localizedDescription), \(error.userInfo)")
    }
    return nil
  }

  // finds an NSManagedObject with given ObjectID as string
  class func objectBy(objectID: String) -> Self? {
    if let objectIDURL = URL(string: objectID) {
      let coordinator = CoreDataManager.shared.persistentContainer.persistentStoreCoordinator
      if let managedObjectID = coordinator.managedObjectID(forURIRepresentation: objectIDURL) {
        return CoreDataManager.shared.context.object(with: managedObjectID) as? Self
      }
    }
    return nil
  }
}
