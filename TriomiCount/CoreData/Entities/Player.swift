//
//  Player+CoreDataClass.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 03.02.22.
//
//

import Foundation
import CoreData
import UIKit
import SwiftUI

@objc(Player)
public class Player: NSManagedObject {
  @NSManaged public var id: UUID?
  @NSManaged public var createdOn: Date?
  @NSManaged public var currentScore: Int16
  @NSManaged public var highscore: Int64
  @NSManaged public var name: String?
  @NSManaged public var position: Int16
  @NSManaged public var sessions: NSSet?
  @NSManaged public var sessionsPlayed: Int16
  @NSManaged public var sessionsWon: Int16
  @NSManaged public var playerInTurn: Turn?
  @NSManaged public var favoriteColor: UIColor?
  @NSManaged public var sessionScores: NSSet?

  var isChosen: Bool = false

  convenience init(name: String, context: NSManagedObjectContext) {
    self.init(context: context)
    self.id = UUID()
    self.createdOn = Date()
    self.name = name
  }

  public var gameScoreDictsArray: [SessionScore] {
    let gameScoreDictsSet = sessionScores as? Set<SessionScore> ?? []

    return Array.init(gameScoreDictsSet)
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

  var wrappedLastScore: Int16 {
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

  public var wrappedFavoriteColor: UIColor {
    get { favoriteColor ?? .blue }
    set { favoriteColor = newValue }
  }
}

extension Player: Identifiable {}

// MARK: Generated accessors for sessionScores
extension Player {

  @objc(addSessionScoresObject:)
  @NSManaged public func addToSessionScores(_ value: SessionScore)

  @objc(removeSessionScoresObject:)
  @NSManaged public func removeFromSessionScores(_ value: SessionScore)

  @objc(addSessionScores:)
  @NSManaged public func addToSessionScores(_ values: NSSet)

  @objc(removeSessionScores:)
  @NSManaged public func removeFromSessionScores(_ values: NSSet)

}
