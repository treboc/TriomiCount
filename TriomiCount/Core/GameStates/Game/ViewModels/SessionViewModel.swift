//
//  SessionViewModel.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import Foundation
import SwiftUI

class SessionViewModel: ObservableObject {
  @EnvironmentObject var appState: AppState

  enum SessionState: Equatable {
    case exited
    case playing
    case willEnd
    case didEnd
  }

  enum BonusEvent: LocalizedStringKey, CaseIterable {
    case none = "sessionView.bonusEventPicker.none"
    case bridge = "sessionView.bonusEventPicker.bridge"
    case hexagon = "sessionView.bonusEventPicker.hexagon"
    case twoHexagons = "sessionView.bonusEventPicker.twoHexagons"
    case threeHexagons = "sessionView.bonusEventPicker.threeHexagons"
  }

  // MARK: - SessionState Playing
  let store = PersistentStore.shared

  @Published var session: Session
  @Published var state: SessionState = .playing
  var currentPlayerOnTurn: Player? {
    let players = session.playersArray.count
    let turns = session.turnsArray.count

    if turns == 0 {
      if let firstPlayer = session.playersArray.first {
        return firstPlayer
      }
    } else {
      if let player = session.playersArray[safe: turns % players] {
        return player
      }
    }
    return nil
  }

  @AppStorage("sessionID") var sessionID: Int = 0

  init(lastSession: Session) {
    self.session = lastSession
  }

  init(_ players: [Player]) {
    self.session = Session(players: players, context: store.context)
  }

  // MARK: - Score Calculation
  @Published var scoreSliderValue: Float = 0
  @Published var timesDrawn: Int = 0 {
    didSet {
      if timesDrawn != 3 {
        playedCard = true
      }
    }
  }
  @Published var playedCard: Bool = true {
    didSet {
      if !playedCard {
        bonusEvent = .none
      }
    }
  }
  @Published var bonusEvent: BonusEvent = .none
  @Published var bonusEventPickerOverlayIsShown = false

  var calculatedScore: Int16 {
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

    return Int16(calculatedScore)
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
    guard let player = currentPlayerOnTurn else { return }
    // update the current player with the score from the currentTurnScore
    updateScore(of: player, with: calculatedScore)

    // append the actual turn to the turns-array to keep track of the turns,
    let turn = Turn(session, score: calculatedScore, playerOnTurn: player)
    session.addToTurns(turn)

    saveSessionState()
    resetTurnState()
  }

  func undoLastTurn() {
    guard let lastTurn = session.turnsArray.last else { return }
    let lastPlayer = session.playersArray.first { $0.id == lastTurn.playerID }
    updateScore(of: lastPlayer, with: -lastTurn.score)
    session.removeFromTurns(lastTurn)
    store.context.delete(lastTurn)
    saveSessionState()
  }

  func updateScore(of player: Player?, with score: Int16) {
    if let player = player {
      var currentPlayersScore: Int16 = 0

      let turns = session.turnsArray.filter { $0.playerID == player.id }
      for turn in turns {
        currentPlayersScore += turn.score
      }
      currentPlayersScore += score
      player.currentScore = currentPlayersScore
    }
  }

  // MARK: - SessionState Ending
  // Alert for ending and exiting the session
  @Published var showEndSessionAlert: Bool = false
  @Published var showExitSessionAlert: Bool = false

  var lastPlayer: Player?
  @Published var playersWithoutLastPlayer: [Player] = []
  @Published var playerToAskForPointsIndex: Int = 0
  var playerToAskForPoints: Player? {
    return playersWithoutLastPlayer[safe: playerToAskForPointsIndex]
  }
  @Published var scoreOfPlayersWithoutLastPlayer: Int16 = 0
  @Published var isTie: Bool = false

  func sessionWillEnd() {
    lastPlayer = currentPlayerOnTurn
    if session.players?.count == 1 {
      endSession()
    }

    playersWithoutLastPlayer = session.playersArray.filter {
      $0 != currentPlayerOnTurn
    }

    if isTie {
      endSession()
    } else {
      state = .willEnd
    }
  }

  func addPoints(with points: Int16) {
    scoreOfPlayersWithoutLastPlayer += points

    if playerToAskForPointsIndex < playersWithoutLastPlayer.count - 1 {
      playerToAskForPointsIndex += 1
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
          player.highscore = Int64(player.currentScore)
        }
        _ = SessionScore.init(sessionKey: session.objectID.uriRepresentation().absoluteString, player: player)
      }

      sessionID += 1
      session.id = Int16(sessionID)

      session.hasEnded = true
      state = .didEnd
      store.saveContext(context: store.context)
    }
  }

  func saveSessionState() {
    if session.hasChanges {
      store.saveContext(context: store.context)
    }
  }
}

extension SessionViewModel {
  func exitSessionButtonTapped(exitSession: () -> Void) {
    if session.turnsArray.count > 0 {
      showExitSessionAlert.toggle()
    } else {
      exitSession()
    }
  }
}
