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
  @NSManaged public var sessionKey: String
  @NSManaged public var scoreValue: Int16
  @NSManaged public var playerID: String

  convenience init(sessionKey: String, player: Player, context: NSManagedObjectContext = CoreDataManager.shared.context) {
    self.init(context: context)
    self.id = UUID()
    self.sessionKey = sessionKey
    self.scoreValue = player.currentScore
    self.playerID = player.objectID.uriRepresentation().absoluteString
  }

  var playerName: String {
    if let player = Player.objectBy(objectID: playerID) {
      return player.wrappedName
    } else {
      return "Unknown Player"
    }
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
