//
//  Session+CoreDataProperties.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//
//

import Foundation
import CoreData

@objc(Session)
public class Session: NSManagedObject {
}

extension Session {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
    return NSFetchRequest<Session>(entityName: "Session")
  }

  @NSManaged public var id: UUID
  @NSManaged public var sessionCounter: Int16
  @NSManaged public var startedOn: Date?
  @NSManaged public var endedOn: Date?
  @NSManaged public var hasEnded: Bool
  @NSManaged public var winnerID: String?
  @NSManaged public var turns: NSSet?
  @NSManaged public var players: NSSet?
  @NSManaged public var playerNamesHash: Int64

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

  var startedOnAsString: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: self.wrappedStartedOn)
  }

  var winner: String? {
    if let objectIDURL = URL(string: wrappedWinnerID) {
      let coordinator: NSPersistentStoreCoordinator = CoreDataManager.shared.persistentContainer.persistentStoreCoordinator
      if let managedObjectID = coordinator.managedObjectID(forURIRepresentation: objectIDURL) {
        let winner = CoreDataManager.shared.context.object(with: managedObjectID) as? Player
        return winner?.wrappedName ?? "No Player with this ID found."
      }
    }
    return nil
  }

  func playedBy() -> String {
    return playersArray.sorted { $0.wrappedName < $1.wrappedName }.compactMap { $0.name }.formatted()
  }
}

// MARK: - Fronting Properties
extension Session {
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

  public var wrappedWinnerID: String {
    get { winnerID ?? "No ID found." }
    set { winnerID = newValue }
  }
}

// MARK: Generated accessors for turns
extension Session {
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
extension Session {
  @objc(addPlayersObject:)
  @NSManaged public func addToPlayers(_ value: Player)

  @objc(removePlayersObject:)
  @NSManaged public func removeFromPlayers(_ value: Player)

  @objc(addPlayers:)
  @NSManaged public func addToPlayers(_ values: NSSet)

  @objc(removePlayers:)
  @NSManaged public func removeFromPlayers(_ values: NSSet)
}

extension Session: Identifiable {}
