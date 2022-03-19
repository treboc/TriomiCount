//
//  Turn+CoreDataProperties.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//
//

import Foundation
import CoreData


extension Turn {
  @NSManaged public var id_: UUID
  @NSManaged public var createdOn_: Date
  @NSManaged public var game: Game?
  
  convenience init(_ game: Game) {
    self.init(context: PersistentStore.shared.context)
    self.game = game
    self.id = UUID()
    self.createdOn = Date()

    if let players = game.players {
      self.addToPlayersInTurn(players)
    }
  }

  @nonobjc public class func fetchRequest() -> NSFetchRequest<Turn> {
    return NSFetchRequest<Turn>(entityName: "Turn")
  }
  
  public override func awakeFromInsert() {
    setPrimitiveValue(UUID(), forKey: "id")
  }
  
  public var id: UUID {
    get { id_ }
    set { id_ = newValue}
  }
  
  public var createdOn: Date {
    get { createdOn_ }
    set { createdOn_ = newValue }
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

extension Turn: Identifiable {
  
}

extension Turn {
  class func allTurns() -> [Turn] {
    return allObjects(context: PersistentStore.shared.context) as! [Turn]
  }
  
  class func allTurnsFR() -> NSFetchRequest<Turn> {
    let request: NSFetchRequest<Turn> = Turn.fetchRequest()
    request.sortDescriptors = []
    return request
  }
}
