//
//  PlayerService.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.07.22.
//

import Foundation
import CoreData
import UIKit

public class PlayerService: EntityServiceBase {
  static func addNewPlayer(_ name: String,
                           favoriteColor: UIColor = .red,
                           in context: NSManagedObjectContext = context) {
    let player = Player(context: context)
    player.id = UUID()
    player.createdOn = .now
    player.name = name
    player.favoriteColor = favoriteColor

    CoreDataManager.shared.save()
  }

  static func toggleChosenState(_ player: Player, in context: NSManagedObjectContext? = nil) {
    let context = context ?? CoreDataManager.shared.context
    player.isChosen.toggle()
    CoreDataManager.shared.save(context: context)
  }

  static func updateScore(of player: Player, with score: Int16, in context: NSManagedObjectContext? = nil) {
    let context = context ?? CoreDataManager.shared.context
    player.currentScore += score
    CoreDataManager.shared.save(context: context)
  }

  static func incrementSessionsWon(of player: Player, in context: NSManagedObjectContext? = nil) {
    let context = context ?? CoreDataManager.shared.context
    player.sessionsWon += 1
    CoreDataManager.shared.save(context: context)
  }

  static func increaseSessionsPlayed(of player: Player, in context: NSManagedObjectContext? = nil) {
    let context = context ?? CoreDataManager.shared.context
    player.sessionsPlayed += 1
    CoreDataManager.shared.save(context: context)
  }

  static func getPosition(of player: Player, in collection: [Player]) -> Int16? {
    if let index = collection.firstIndex(of: player) {
      return Int16(index + 1)
    }
    return nil
  }
}
