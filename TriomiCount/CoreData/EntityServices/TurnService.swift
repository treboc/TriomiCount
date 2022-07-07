//
//  TurnService.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 07.07.22.
//

import CoreData

public class TurnService: EntityServiceBase {
  static func addTurn(with turnProperties: TurnProperties, in context: NSManagedObjectContext = context) {
    let turn = Turn(context: context)
    turn.score = turnProperties.calculatedScore
    turn.playerID = turnProperties.playerOnTurn.id
    turn.scoreSliderValue = turnProperties.scoreSliderValue
    turn.timesDrawn = turnProperties.timesDrawn
    turn.playedCard = turnProperties.playedCard
    turnProperties.session.addToTurns(turn)
    CoreDataManager.shared.save()
  }

  struct TurnProperties {
    let session: Session
    let calculatedScore: Int16
    let playerOnTurn: Player
    let scoreSliderValue: Int16
    let timesDrawn: Int16
    let playedCard: Bool
  }
}
