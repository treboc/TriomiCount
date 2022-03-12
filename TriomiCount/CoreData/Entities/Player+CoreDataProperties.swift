//
//  Player+CoreDataClass.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 03.02.22.
//
//

import Foundation
import CoreData

extension Player {
  @NSManaged public var createdOn_: Date?
  @NSManaged public var currentScore_: Int64
  @NSManaged public var highscore_: Int64
  @NSManaged public var id_: UUID?
  @NSManaged public var name_: String?
  @NSManaged public var position_: Int16
  @NSManaged public var games: NSSet?
  @NSManaged public var playerInTurn: Turn?
  @NSManaged public var gameScores_: [String]?
    
  public override func awakeFromInsert() {
    setPrimitiveValue(UUID(), forKey: "id")
  }
  
  convenience init(name: String, position: Int16, context: NSManagedObjectContext) {
    self.init(context: context)
    self.position = position
    self.id = UUID()
    self.createdOn = Date()
    self.name = name
  }
}

// MARK: - Fronting Properties
extension Player {
  public var id: UUID {
    get { id_ ?? UUID() }
    set { id_ = newValue}
  }
  
  var name: String {
    get { name_ ?? "" }
    set { name_ = newValue }
  }
  
  var position: Int16 {
    get { position_ }
    set { position_ = newValue }
  }
  
  var currentScore: Int64 {
    get { currentScore_ }
    set { currentScore_ = newValue }
  }
  
  var highscore: Int64 {
    get { highscore_ }
    set { highscore_ = newValue }
  }
  
  var createdOn: Date {
    get { createdOn_ ?? Date() }
    set { createdOn_ = newValue }
  }
  
  public var gameScores: [String] {
    get { gameScores_ ?? [] }
    set { gameScores_ = newValue }
  }
  
  // MARK: - Computed Properties
  
  var canBeSaved: Bool {
    guard let name = name_ else { return false }
    return name.count > 0
  }
  
  var gamesWon: Int {
    return Game.allGames().filter({ $0.winnerID == self.id }).count
  }
  
  var gamesPlayed: Int {
    return Game.allGames().filter({ $0.playersArray.contains(where: { $0.id == self.id }) }).count
  }
  
  // MARK: - Useful Fetch Requests
  
  class func allPlayersFR() -> NSFetchRequest<Player> {
    let request: NSFetchRequest<Player> = NSFetchRequest<Player>(entityName: "Player")
    request.sortDescriptors = [NSSortDescriptor(key: "createdOn_", ascending: true)]
    return request
  }
  
  class func allPlayersByHighscoreFR() -> NSFetchRequest<Player> {
    let request: NSFetchRequest<Player> = NSFetchRequest<Player>(entityName: "Player")
    request.sortDescriptors = [NSSortDescriptor(key: "highscore_", ascending: false)]
    return request
  }
  
  class func fetchPlayersBy(_ sortDescriptorKey: String, ascending: Bool) -> NSFetchRequest<Player> {
    let request: NSFetchRequest<Player> = NSFetchRequest<Player>(entityName: "Player")
    request.sortDescriptors = [NSSortDescriptor(key: sortDescriptorKey, ascending: ascending)]
    return request
  }
  
  func getPlayersGameScore(ofGame game: UUID) -> Int64? {
    if let gameScores = GameScoreDict.getGameScoreDictsWith(gameKey: game) {
      return gameScores.first{ $0.playerID == self.id }?.scoreValue
    }
    return nil
  }
  
  // MARK: - Class functions for CRUD operations
  
  class func count() -> Int {
    return count(context: PersistentStore.shared.context)
  }
  
  class func allPlayers() -> [Player] {
    return allObjects(context: PersistentStore.shared.context) as! [Player]
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
    newPlayer.name = name
    newPlayer.id = UUID()
    newPlayer.createdOn = Date()
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
}

extension Player: Identifiable {
  
}

