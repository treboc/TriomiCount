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

  @NSManaged public var id: Int16
  @NSManaged public var startedOn: Date?
  @NSManaged public var endedOn: Date?
  @NSManaged public var hasEnded: Bool
  @NSManaged public var winnerID: String?
  @NSManaged public var turns: NSSet?
  @NSManaged public var players: NSSet?

  public var turnsArray: [Turn] {
    let turnsSet = turns as? Set<Turn> ?? []

    return turnsSet.sorted {
      $0.wrappedCreatedOn < $1.wrappedCreatedOn
    }
  }

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
      player.increaseGamesPlayed()
      player.isChosen = false
    }

    self.addToPlayers(NSSet(array: players))
    self.turns = NSSet()
    self.startedOn = Date()
  }
}

// MARK: - Fronting Properties
extension Game {
  public var wrappedStartedOn: Date {
    get { startedOn ?? Date() }
    set { startedOn = newValue }
  }

  public var wrappedEndedOn: Date {
    get { endedOn ?? Date() }
    set { endedOn = newValue }
  }

  public var wrappedHasEnded: Bool {
    get { hasEnded }
    set { hasEnded = newValue }
  }

  public var wrappedWinnerID: String? {
    get { winnerID }
    set { winnerID = newValue }
  }
}

// MARK: - Class Functions
extension Game {
  /// 1) get all not yet finished games
  /// 2) make sure, there's atleast one not finished game
  /// 3) loop over all, delete all but not the latest

  class func getLastNotFinishedSession(context: NSManagedObjectContext) -> Game? {
    let predicate = NSPredicate(format: "hasEnded = false")
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
    return allObjects(context: PersistentStore.shared.context) as? [Game] ?? []
  }
}

// MARK: Generated accessors for turns
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

// MARK: Generated accessors for players
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

extension Game: Identifiable {}
