//
//  PersistentStore.swift
//  SecurePhotos
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
    persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
      if let error = error as NSError? {
        fatalError("Unresolved loadPersistentStores error \(error), \(error.userInfo)")
      }
    })
  }

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
}
