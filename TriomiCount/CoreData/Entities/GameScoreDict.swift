//
//  GameScoreDict+CoreDataProperties.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 08.03.22.
//
//

import Foundation
import CoreData

@objc(GameScoreDict)
public class GameScoreDict: NSManagedObject {}

extension GameScoreDict {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<GameScoreDict> {
    let fetchRequest = NSFetchRequest<GameScoreDict>(entityName: "GameScoreDict")
    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \GameScoreDict.scoreValue, ascending: true)]
    return fetchRequest
  }

  @NSManaged public var id: UUID
  @NSManaged public var gameKey: String
  @NSManaged public var scoreValue: Int64
  @NSManaged public var playerID: String

  convenience init(gameKey: String, player: Player, context: NSManagedObjectContext = PersistentStore.shared.context) {
    self.init(context: context)
    self.id = UUID()
    self.gameKey = gameKey
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

extension GameScoreDict: Identifiable {}

extension GameScoreDict {
  // finds an NSManagedObject with the given GameID (there should only be one, really)
  class func getGameScoreDictWith(gameKey: String, context: NSManagedObjectContext = PersistentStore.shared.context) -> [GameScoreDict]? {
    let fetchRequest: NSFetchRequest<GameScoreDict> =
    NSFetchRequest<GameScoreDict>(entityName: GameScoreDict.description())
    fetchRequest.predicate = NSPredicate(format: "gameKey == %@", gameKey as CVarArg)
    do {
      let results = try context.fetch(fetchRequest)
      return results
    } catch let error as NSError {
      NSLog("Error fetching NSManagedObjects \(Self.description()): \(error.localizedDescription), \(error.userInfo)")
    }
    return nil
  }

  class func getGameScoreDictsWith(gameKey: NSManagedObjectID,
                                   context: NSManagedObjectContext = PersistentStore.shared.context)
  -> [GameScoreDict]? {
    let fetchRequest: NSFetchRequest<GameScoreDict> =
    NSFetchRequest<GameScoreDict>(entityName: GameScoreDict.description())
    fetchRequest.predicate = NSPredicate(format: "gameKey == %@", gameKey as CVarArg)
    do {
      let results = try context.fetch(fetchRequest)
      return results
    } catch let error as NSError {
      NSLog("Error fetching NSManagedObjects \(Self.description()): \(error.localizedDescription), \(error.userInfo)")
    }
    return []
  }
}
