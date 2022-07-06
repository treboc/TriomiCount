//
//  EntityServiceBase.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.07.22.
//

import CoreData

public class EntityServiceBase {
  static func allObjects<T: NSManagedObject>(_ type: T.Type, in context: NSManagedObjectContext = CoreDataManager.shared.context) -> [T] {
    let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: T.description())
    do {
      let result = try context.fetch(fetchRequest)
      return result
    } catch let error as NSError {
      NSLog("Error fetching NSManagedObjects \(T.description()): \(error.localizedDescription), \(error.userInfo)")
    }
    return []
  }

  static func object<T: NSManagedObject>(with id: UUID,
                                         in context: NSManagedObjectContext = CoreDataManager.shared.context) -> T? {
    let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: T.description())
    fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    do {
      let results = try context.fetch(fetchRequest)
      return results.first
    } catch let error as NSError {
      NSLog("Error fetching NSManagedObjects \(T.description()): \(error.localizedDescription), \(error.userInfo)")
    }
    return nil
  }

  // finds an NSManagedObject with given ObjectID as string
  static func object<T: NSManagedObject>(with objectID: String,
                                         in context: NSManagedObjectContext = CoreDataManager.shared.context) -> T? {
    if let objectIDURL = URL(string: objectID) {
      let coordinator = CoreDataManager.shared.persistentContainer.persistentStoreCoordinator
      if let managedObjectID = coordinator.managedObjectID(forURIRepresentation: objectIDURL) {
        return context.object(with: managedObjectID) as? T
      }
    }
    return nil
  }

  static func countAllObjects<T: NSManagedObject>(_ type: T.Type, context: NSManagedObjectContext) -> Int {
    let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: T.description())
    do {
      let result = try context.count(for: fetchRequest)
      return result
    } catch let error as NSError {
      NSLog("Error counting NSManagedObjects \(T.description()): \(error.localizedDescription), \(error.userInfo)")
    }
    return 0
  }

   static func deleteObject<T: NSManagedObject>(_ entity: T,
                                                in context: NSManagedObjectContext = CoreDataManager.shared.context) {
    context.delete(entity)
    CoreDataManager.shared.save(context: context)
  }
}
