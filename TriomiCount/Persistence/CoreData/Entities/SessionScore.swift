//
//  SessionScore+CoreDataProperties.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 08.03.22.
//
//

import Foundation
import CoreData

@objc(SessionScore)
public class SessionScore: NSManagedObject {}

extension SessionScore {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<SessionScore> {
    let fetchRequest = NSFetchRequest<SessionScore>(entityName: "SessionScore")
    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \SessionScore.scoreValue, ascending: true)]
    return fetchRequest
  }

  @NSManaged public var id: UUID
  @NSManaged public var sessionID: UUID
  @NSManaged public var scoreValue: Int16
  @NSManaged public var player: Player?

  convenience init(sessionID: UUID, scoreValue: Int16, player: Player, context: NSManagedObjectContext = CoreDataManager.shared.context) {
    self.init(context: context)
    self.id = UUID()
    self.sessionID = sessionID
    self.scoreValue = scoreValue
    self.player = player
  }
}

extension SessionScore: Identifiable {}

extension SessionScore {
  class func getSessionScoreDictWith(sessionKey: String, context: NSManagedObjectContext = CoreDataManager.shared.context) -> [SessionScore]? {
    let fetchRequest: NSFetchRequest<SessionScore> =
    NSFetchRequest<SessionScore>(entityName: SessionScore.description())
    fetchRequest.predicate = NSPredicate(format: "sessionKey == %@", sessionKey as CVarArg)
    do {
      let results = try context.fetch(fetchRequest)
      return results
    } catch let error as NSError {
      NSLog("Error fetching NSManagedObjects \(Self.description()): \(error.localizedDescription), \(error.userInfo)")
    }
    return nil
  }

  class func getSessionScoresWith(sessionKey: NSManagedObjectID, context: NSManagedObjectContext = CoreDataManager.shared.context) -> [SessionScore]? {
    let fetchRequest: NSFetchRequest<SessionScore> =
    NSFetchRequest<SessionScore>(entityName: SessionScore.description())
    fetchRequest.predicate = NSPredicate(format: "sessionKey == %@", sessionKey as CVarArg)
    do {
      let results = try context.fetch(fetchRequest)
      return results
    } catch let error as NSError {
      NSLog("Error fetching NSManagedObjects \(Self.description()): \(error.localizedDescription), \(error.userInfo)")
    }
    return []
  }
}
