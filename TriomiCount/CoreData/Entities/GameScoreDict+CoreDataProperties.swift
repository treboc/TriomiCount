//
//  GameScoreDict+CoreDataProperties.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 08.03.22.
//
//

import Foundation
import CoreData


extension GameScoreDict {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameScoreDict> {
      let fetchRequest = NSFetchRequest<GameScoreDict>(entityName: "GameScoreDict")
      fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \GameScoreDict.scoreValue, ascending: true)]
      return fetchRequest
    }

    @NSManaged public var id: UUID
    @NSManaged public var gameKey: UUID
    @NSManaged public var scoreValue: Int64
    @NSManaged public var playerID: UUID
  
  convenience init(gameKey: UUID, player: Player, context: NSManagedObjectContext = PersistentStore.shared.context) {
    self.init(context: context)
    self.id = UUID()
    self.gameKey = gameKey
    self.scoreValue = player.currentScore
    self.playerID = player.id
  }

}

extension GameScoreDict: Identifiable {

}

extension GameScoreDict {
  // finds an NSManagedObject with the given UUID (there should only be one, really)
  class func getGameScoreDictWith(gameKey: UUID, context: NSManagedObjectContext = PersistentStore.shared.context) -> GameScoreDict? {
    let fetchRequest: NSFetchRequest<GameScoreDict> = NSFetchRequest<GameScoreDict>(entityName: GameScoreDict.description())
    fetchRequest.predicate = NSPredicate(format: "gameKey == %@", gameKey as CVarArg)
    do {
      let results = try context.fetch(fetchRequest)
      return results.first
    } catch let error as NSError {
      NSLog("Error fetching NSManagedObjects \(Self.description()): \(error.localizedDescription), \(error.userInfo)")
    }
    return nil
  }
  
  class func getGameScoreDictsWith(gameKey: UUID, context: NSManagedObjectContext = PersistentStore.shared.context) -> [GameScoreDict]? {
    let fetchRequest: NSFetchRequest<GameScoreDict> = NSFetchRequest<GameScoreDict>(entityName: GameScoreDict.description())
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
