//
//  Game+CoreDataProperties.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//
//

import Foundation
import CoreData


extension Game {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
    return NSFetchRequest<Game>(entityName: "Game")
  }
  
  @NSManaged public var startedOn_: Date?
  @NSManaged public var endedOn_: Date?
  @NSManaged public var hasEnded_: Bool
  @NSManaged public var id_: UUID?
  @NSManaged public var winnerID_: UUID?
  @NSManaged public var turns: NSSet?
  @NSManaged public var players: NSSet?
  
  public var turnsArray: [Turn] {
    let turnsSet = turns as? Set<Turn> ?? []

    return turnsSet.sorted {
      $0.createdOn_ < $1.createdOn_
    }
  }
  
  // TODO: refactor to use this with UUIDs instead of the NSSet above
  public var playersArray: [Player] {
    let playersSet = players as? Set<Player> ?? []

    return playersSet.sorted {
      $0.position < $1.position
    }
  }
  
  convenience init(players: [Player], context: NSManagedObjectContext) {
    self.init(context: context)
    
    for player in players {
      player.currentScore = 0
      player.isChosen = false
    }
    
    self.addToPlayers(NSSet(array: players))
    
    self.turns = NSSet()
    self.startedOn_ = Date()
    self.id = UUID()
  }
}

// MARK: - Fronting Properties
extension Game {
  public var id: UUID {
    get { id_ ?? UUID() }
    set { id_ = newValue}
  }
  
  public var startedOn: Date {
    get { startedOn_ ?? Date() }
    set { startedOn_ = newValue }
  }
  
  public var endedOn: Date {
    get { endedOn_ ?? Date() }
    set { endedOn_ = newValue }
  }
  
  public var hasEnded: Bool {
    get { hasEnded_ }
    set { hasEnded_ = newValue }
  }
  
  public var winnerID: UUID? {
    get { winnerID_ }
    set { winnerID_ = newValue }
  }
}

// MARK: - Class Functions
extension Game {
  /// 1) get all not yet finished games
  /// 2) make sure, there's atleast one not finished game
  /// 3) loop over all, delete all but not the latest

  class func getLastNotFinishedSession(context: NSManagedObjectContext) -> Game? {
    let predicate = NSPredicate(format: "hasEnded_ = false")
    let fetchRequest: NSFetchRequest<Game> = NSFetchRequest<Game>(entityName: Game.description())
    fetchRequest.predicate = predicate
    do {
      let result = try context.fetch(fetchRequest)
      guard let lastSession = result.last else { return nil }

      // deleting all older, not finished sessions, but the last
      for session in result {
        if (session != lastSession) && (!session.hasEnded) {
          PersistentStore.shared.context.delete(session)
        }
      }

      if !lastSession.hasEnded { return lastSession }
    } catch let error as NSError {
      print("Could not find any session that has not ended. Error: \(error.localizedDescription)")
    }
    return nil
  }
  
  class func allGames() -> [Game] {
    return allObjects(context: PersistentStore.shared.context) as! [Game]
  }
}


// MARK: Generated accessors for turns_
extension Game {
  
  @objc(addTurnsObject:)
  @NSManaged public func addToTurns(_ value: Turn)
  
  @objc(removeTurnsObject:)
  @NSManaged public func removeFromTurns(_ value: Turn)
  
  @objc(addTurns:)
  @NSManaged public func addToTurns(_ values: NSSet)
  
  @objc(removeTurns:)
  @NSManaged public func removeFromTurns(_ values: NSSet)
  
}

// MARK: Generated accessors for players_
extension Game {
  
  @objc(addPlayersObject:)
  @NSManaged public func addToPlayers(_ value: Player)
  
  @objc(removePlayersObject:)
  @NSManaged public func removeFromPlayers(_ value: Player)
  
  @objc(addPlayers:)
  @NSManaged public func addToPlayers(_ values: NSSet)
  
  @objc(removePlayers:)
  @NSManaged public func removeFromPlayers(_ values: NSSet)
  
}

extension Game: Identifiable {
  
}
