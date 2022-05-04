//
//  Player+CoreDataClass.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 03.02.22.
//
//

import Foundation
import CoreData

@objc(Player)
public class Player: NSManagedObject {
  var isChosen: Bool = false
}

extension Player {
  @NSManaged public var createdOn: Date?
  @NSManaged public var currentScore: Int64
  @NSManaged public var highscore: Int64
  @NSManaged public var name: String?
  @NSManaged public var position: Int16
  @NSManaged public var sessions: NSSet?
  @NSManaged public var sessionsPlayed: Int16
  @NSManaged public var sessionsWon: Int16
  @NSManaged public var playerInTurn: Turn?
  @NSManaged public var sessionScores: [String]?

  convenience init(name: String, position: Int16, context: NSManagedObjectContext) {
    self.init(context: context)
    self.position = position
    self.createdOn = Date()
    self.name = name
  }
}

// MARK: - Fronting Properties
extension Player {
  var wrappedName: String {
    get { name ?? "" }
    set { name = newValue }
  }

  var wrappedPosition: Int16 {
    get { position }
    set { position = newValue }
  }

  var wrappedLastScore: Int64 {
    get { currentScore }
    set { currentScore = newValue }
  }

  var wrappedHighscore: Int64 {
    get { highscore }
    set { highscore = newValue }
  }

  var wrappedCreatedOn: Date {
    get { createdOn ?? Date() }
    set { createdOn = newValue }
  }

  public var wrappedSessionScores: [String] {
    get { sessionScores ?? [] }
    set { sessionScores = newValue }
  }

  // MARK: - Computed Properties
  var canBeSaved: Bool {
    guard let name = name else { return false }
    return name.count > 0
  }

  // MARK: - Useful Fetch Requests
  class func allPlayersFR() -> NSFetchRequest<Player> {
    let request: NSFetchRequest<Player> = NSFetchRequest<Player>(entityName: "Player")
    request.sortDescriptors = [NSSortDescriptor(key: "createdOn", ascending: true)]
    return request
  }

  class func allPlayersByHighscoreFR() -> NSFetchRequest<Player> {
    let request: NSFetchRequest<Player> = NSFetchRequest<Player>(entityName: "Player")
    request.sortDescriptors = [NSSortDescriptor(key: "highscore", ascending: false)]
    return request
  }

  class func fetchPlayersBy(_ sortDescriptorKey: String, ascending: Bool) -> NSFetchRequest<Player> {
    let request: NSFetchRequest<Player> = NSFetchRequest<Player>(entityName: "Player")
    request.sortDescriptors = [NSSortDescriptor(key: sortDescriptorKey, ascending: ascending)]
    return request
  }

  func getPlayerScore(ofSession sessionID: NSManagedObjectID) -> Int64? {
    if let sessionScores = SessionScore.getSessionScoresWith(sessionKey: sessionID) {
      return sessionScores.first { $0.playerID == self.objectID.description }?.scoreValue
    }
    return nil
  }

  // MARK: - Class functions for CRUD operations

  class func count() -> Int {
    return count(context: PersistentStore.shared.context)
  }

  class func allPlayers() -> [Player] {
    return allObjects(context: PersistentStore.shared.context) as? [Player] ?? []
  }

  class func object(withID id: UUID) -> Player? {
    return object(id: id, context: PersistentStore.shared.context) as Player?
  }

  private func isValid(name string: String) -> Bool {
    guard !string.isEmpty else { return false }
    guard string.count < 15  else { return false }

    return true
  }

  class func addNewPlayer(name: String) {
    let context = PersistentStore.shared.context
    let newPlayer = Player(context: context)
    newPlayer.wrappedName = name
    newPlayer.wrappedCreatedOn = Date()
    newPlayer.sessionsPlayed = 0
    newPlayer.sessionsWon = 0
    PersistentStore.shared.saveContext(context: context)
  }

  class func deletePlayer(_ playerEntity: Player) {
    let context = PersistentStore.shared.context
    context.delete(playerEntity)
    PersistentStore.shared.saveContext(context: context)
  }

  // MARK: - Object Methods

  // toggles the isChosen flag for a player
  func toggleIsChosenStatus() { self.isChosen.toggle() }

  func updateScore(score: Int64) {
    self.currentScore += score
  }

  func increaseSessionsWon() {
    sessionsWon += 1
  }

  func increaseSessionsPlayed() {
    sessionsPlayed += 1
  }
}

extension Player: Identifiable {}
