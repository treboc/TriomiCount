//
//  Turn+CoreDataProperties.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//
//

import Foundation
import CoreData

@objc(Turn)
public class Turn: NSManagedObject {}

extension Turn {
  @NSManaged public var createdOn: Date?
  @NSManaged public var game: Session?

  convenience init(_ game: Session) {
    self.init(context: PersistentStore.shared.context)
    self.game = game
    self.wrappedCreatedOn = Date()

    if let players = game.players {
      self.addToPlayersInTurn(players)
    }
  }

  @nonobjc public class func fetchRequest() -> NSFetchRequest<Turn> {
    return NSFetchRequest<Turn>(entityName: "Turn")
  }

  public var wrappedCreatedOn: Date {
    get { createdOn ?? Date() }
    set { createdOn = newValue }
  }

}

// MARK: Generated accessors for playersInTurn
extension Turn {
  @objc(addPlayersInTurnObject:)
  @NSManaged public func addToPlayersInTurn(_ value: Player)

  @objc(removePlayersInTurnObject:)
  @NSManaged public func removeFromPlayersInTurn(_ value: Player)

  @objc(addPlayersInTurn:)
  @NSManaged public func addToPlayersInTurn(_ values: NSSet)

  @objc(removePlayersInTurn:)
  @NSManaged public func removeFromPlayersInTurn(_ values: NSSet)

}

extension Turn: Identifiable {}

extension Turn {
  class func allTurns() -> [Turn] {
    return allObjects(context: PersistentStore.shared.context) as? [Turn] ?? []
  }

  class func allTurnsFR() -> NSFetchRequest<Turn> {
    let request: NSFetchRequest<Turn> = Turn.fetchRequest()
    request.sortDescriptors = []
    return request
  }
}
