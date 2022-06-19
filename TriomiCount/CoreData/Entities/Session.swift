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

  var playedBy: String {
    return playersArray.compactMap { $0.name }.formatted()
  }

  var startedOnAsString: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: self.wrappedStartedOn)
  }

  var winner: String? {
    if let objectIDURL = URL(string: wrappedWinnerID) {
      let coordinator: NSPersistentStoreCoordinator = PersistentStore.shared.persistentContainer.persistentStoreCoordinator
      if let managedObjectID = coordinator.managedObjectID(forURIRepresentation: objectIDURL) {
        let winner = PersistentStore.shared.context.object(with: managedObjectID) as? Player
        return winner?.wrappedName ?? "No Player with this ID found."
      }
    }
    return nil
  }

  convenience init(players: [Player], context: NSManagedObjectContext) {
    self.init(context: context)

    for player in players {
      player.currentScore = 0
      player.isChosen = false
    }

    self.addToPlayers(NSSet(array: players))
    self.turns = NSSet()
    self.startedOn = Date()
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

// MARK: - Class Functions
extension Session {
  /// 1) get all not yet finished sessions
  /// 2) make sure, there's atleast one not finished session
  /// 3) loop over all, delete all but not the latest

  class func getLastNotFinishedSession(context: NSManagedObjectContext) -> Session? {
    let predicate = NSPredicate(format: "hasEnded = false")
    let fetchRequest: NSFetchRequest<Session> = NSFetchRequest<Session>(entityName: Session.description())
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

  class func getAllSessions() -> [Session] {
    return allObjects(context: PersistentStore.shared.context) as? [Session] ?? []
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
