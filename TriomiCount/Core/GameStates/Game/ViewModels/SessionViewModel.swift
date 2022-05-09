//
//  SessionViewModel.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import Foundation
import SwiftUI

class SessionViewModel: ObservableObject {
  enum SessionState: Equatable {
    case exited
    case playing
    case willEnd
    case didEnd
  }

  // MARK: - SessionState Playing
  let store = PersistentStore.shared
  let context = PersistentStore.shared.context

  @Published var session: Session
  @Published var sessionState: SessionState = .playing
  var currentPlayerOnTurn: Player? {
    let playerCount = session.playersArray.count
    let turnsCount = session.turnsArray.count

    if turnsCount == 0 {
      if let firstPlayer = session.playersArray.first {
        return firstPlayer
      }
    } else {
      return session.playersArray[turnsCount % playerCount]
    }
    return nil
  }

  @AppStorage("sessionID") var sessionID: Int = 0

  init(lastSession: Session) {
    self.session = lastSession
  }

  init(_ players: [Player]) {
    self.session = Session(players: players, context: context)
  }

  // 2) calculate the current points the player gets for laying the card
  @Published var scoreSliderValue: Float = 0
  @Published var timesDrawn: Int = 0 {
    didSet {
      if timesDrawn != 3 {
        playedCard = true
      }
    }
  }
  @Published var playedCard: Bool = true
  @Published var bonusEvent: BonusEvent = .none
  @Published var bonusEventPickerOverlayIsShown = false

  enum BonusEvent: LocalizedStringKey, CaseIterable {
    case none = "sessionView.bonusEventPicker.none"
    case bridge = "sessionView.bonusEventPicker.bridge"
    case hexagon = "sessionView.bonusEventPicker.hexagon"
    case twoHexagons = "sessionView.bonusEventPicker.twoHexagons"
    case threeHexagons = "sessionView.bonusEventPicker.threeHexagons"
  }

  var calculatedScore: Int64 {
    var calculatedScore = self.scoreSliderValue

    if timesDrawn != 3 {
      calculatedScore = scoreSliderValue - Float(timesDrawn * 5)
    }

    if timesDrawn == 3 && playedCard {
      calculatedScore = scoreSliderValue - 15
    }

    if timesDrawn == 3 && !playedCard {
      calculatedScore = -25
    }

    switch bonusEvent {
    case .none:
      break
    case .bridge:
      calculatedScore += 40
    case .hexagon:
      calculatedScore += 50
    case .twoHexagons:
      calculatedScore += 60
    case .threeHexagons:
      calculatedScore += 70
    }

    return Int64(calculatedScore)
  }

  var turnHasChanges: Bool {
    return scoreSliderValue != 0 || timesDrawn != 0 || bonusEvent != .none
  }

  func resetTurnState() {
    scoreSliderValue = 0
    timesDrawn = 0
    playedCard = true
    bonusEvent = .none
  }

  func nextPlayer() {
    // update the current player with the score from the currentTurnScore
    updateScore(of: currentPlayerOnTurn, with: calculatedScore)

    // append the actual turn to the turns-array to keep track of the turns,
    let newTurn = Turn(session)
    session.addToTurns(newTurn)

    saveSessionState()
    resetTurnState()
  }

  func updateScore(of player: Player?, with score: Int64) {
    if let player = player {
      player.currentScore += score
    }
  }

  // MARK: - SessionState Ending
  // Alert for ending and exiting the session
  @Published var showEndSessionAlert: Bool = false
  @Published var showExitSessionAlert: Bool = false

  var lastPlayer: Player?
  @Published var playersWithoutLastPlayer: [Player] = []
  @Published var playerToAskForPointsIndex: Int = 0
  @Published var playerToAskForPoints: Player?
  @Published var scoreOfPlayersWithoutLastPlayer: Int64 = 0
  @Published var isTie: Bool = false

  func sessionWillEnd() {
    lastPlayer = currentPlayerOnTurn
    if session.players?.count == 1 { endSession() }

    playersWithoutLastPlayer = session.playersArray.filter({ $0 != currentPlayerOnTurn })

    if isTie {
      endSession()
    } else {
      if let player = playersWithoutLastPlayer.first {
        playerToAskForPoints = player
        sessionState = .willEnd
      }
    }
  }

  func addPoints(with points: Int64) {
    scoreOfPlayersWithoutLastPlayer += points

    playerToAskForPointsIndex += 1
    getNextPlayerToAskForPoints()
  }

  func getNextPlayerToAskForPoints() {
    if playerToAskForPointsIndex < playersWithoutLastPlayer.count {
      playerToAskForPoints = playersWithoutLastPlayer[playerToAskForPointsIndex]
    } else {
      endSession()
    }
  }

  // MARK: - SessionState Ended

  func endSession() {
    if let lastPlayer = lastPlayer {
      if !isTie {
        // 25 extra points for placing the last tile
        lastPlayer.currentScore += 25

        // add points from all the other players
        lastPlayer.currentScore += scoreOfPlayersWithoutLastPlayer
      }

      // get winner with highest score
      let winner = session.playersArray.sorted(by: { $0.currentScore > $1.currentScore }).first!
      winner.increaseSessionsWon()
      session.wrappedWinnerID = winner.objectID.uriRepresentation().absoluteString

      for player in session.playersArray {
        if player.currentScore > player.highscore {
          player.highscore = player.currentScore
        }
        _ = SessionScore.init(sessionKey: session.objectID.uriRepresentation().absoluteString, player: player)
      }

      sessionID += 1
      session.id = Int16(sessionID)

      session.hasEnded = true
      sessionState = .didEnd
      store.saveContext(context: context)
    }
  }

  func saveSessionState() {
    if session.hasChanges {
      store.saveContext(context: context)
    }
  }
}
