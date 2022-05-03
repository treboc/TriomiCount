//
//  GameViewModel.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
  enum GameState: Equatable {
    case exited
    case playing
    case isEnding
    case ended
  }

  // MARK: - GameState Playing
  let store = PersistentStore.shared
  let context = PersistentStore.shared.context

  @Published var session: Session
  @Published var gameState: GameState = .playing
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

  @AppStorage("gameID") var gameID: Int = 0

  init(lastGame: Session) {
    self.session = lastGame
  }

  init(_ players: [Player]) {
    self.session = Session(players: players, context: context)
  }

  // 2) calculate the current points the player gets for laying the card
  @Published var scoreSliderValue: Float = 0
  @Published var timesDrawn: Int = 0
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
    // but also in the childViewContext, so that if the game is set back all models are untouched
    let newTurn = Turn(session)
    session.addToTurns(newTurn)

    saveGameState()
    resetTurnState()
  }

  func updateScore(of player: Player?, with score: Int64) {
    if let player = player {
      player.currentScore += score
    }
  }

  // MARK: - GameState Ending
  // Game will end
  // 1) setting up some needed properties
  // 2) get the last player, who was on turn when the game ended, because he gets bonus points
  //    and all the points left of the other players
  // 3) filter out all other players into their own array
  // 4) loop over this array to ask for their points left on their hand
  // 5) after getting points from the last player, call endGame(), to calculate all the points,
  //    saving them and then step over to display the GameResultsView

  // Alert for ending and exiting the game
  @Published var showEndGameAlert: Bool = false
  @Published var showExitGameAlert: Bool = false

  var lastPlayer: Player?
  @Published var playersWithoutLastPlayer: [Player] = []
  @Published var playerToAskForPointsIndex: Int = 0
  @Published var playerToAskForPoints: Player?
  @Published var scoreOfPlayersWithoutLastPlayer: Int64 = 0
  @Published var isTie: Bool = false

  func endingGame() {
    lastPlayer = currentPlayerOnTurn
    if session.players?.count == 1 { endGame() }

    playersWithoutLastPlayer = session.playersArray.filter({ $0 != currentPlayerOnTurn })

    if isTie {
      endGame()
    } else {
      if let player = playersWithoutLastPlayer.first {
        playerToAskForPoints = player
        gameState = .isEnding
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
      endGame()
    }
  }

  // MARK: - GameState Ended

  func endGame() {
    // Currently: For every player, save the current score to the highscore, if it's higher.
    // Want to: End the game, get all points correctly and only save the players highscore, if it's a new record.
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

      gameID += 1
      session.id = Int16(gameID)

      session.hasEnded = true
      gameState = .ended
      store.saveContext(context: context)
    }
  }

  func saveGameState() {
    if session.hasChanges {
      store.saveContext(context: context)
    }
  }
}
