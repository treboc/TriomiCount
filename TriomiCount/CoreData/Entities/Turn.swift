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
  @NSManaged public var session: Session?
  @NSManaged public var score: Int16
  @NSManaged public var playerID: UUID?

  @NSManaged public var scoreSliderValue: Int16
  @NSManaged public var timesDrawn: Int16
  @NSManaged public var playedCard: Bool

  convenience init(_ session: Session,
                   score: Int16,
                   playerOnTurn: Player,
                   scoreSliderValue: Int16,
                   timesDrawn: Int16,
                   playedCard: Bool
  ) {
    self.init(context: PersistentStore.shared.context)
    self.session = session
    self.wrappedCreatedOn = Date()
    self.score = score
    self.playerID = playerOnTurn.id
    self.scoreSliderValue = scoreSliderValue
    self.timesDrawn = timesDrawn
    self.playedCard = playedCard
  }

  @nonobjc public class func fetchRequest() -> NSFetchRequest<Turn> {
    return NSFetchRequest<Turn>(entityName: "Turn")
  }

  public var wrappedCreatedOn: Date {
    get { createdOn ?? Date() }
    set { createdOn = newValue }
  }

  public var player: Player? {
    if let uuid = self.playerID {
      return Player.object(withID: uuid)
    }
    return nil
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
