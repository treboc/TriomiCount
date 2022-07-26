//
//  TurnService.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 07.07.22.
//

import CoreData

public class TurnService: EntityServiceBase {
  static func addTurn(with turnProperties: TurnProperties,
                      in context: NSManagedObjectContext = context) {
    let turn = Turn(session: turnProperties.session,
                    scoreInTurn: turnProperties.calculatedScore,
                    scoreTilNow: turnProperties.playersScoreTilNow,
                    player: turnProperties.player,
                    scoreSliderValue: turnProperties.scoreSliderValue,
                    timesDrawn: turnProperties.timesDrawn,
                    playedCard: turnProperties.playedCard)
    turnProperties.session.addToTurns(turn)
    CoreDataManager.shared.save()
  }

  struct TurnProperties {
    let session: Session
    let calculatedScore: Int16
    let playersScoreTilNow: Int16
    let player: Player
    let scoreSliderValue: Int16
    let timesDrawn: Int16
    let playedCard: Bool
  }
}
