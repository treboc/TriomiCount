//
//  GameViewModel.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import Foundation
import SwiftUI
import PageSheetCore

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
  
  @Published var game: Game?
  @Published var gameState: GameState = .playing
  @Published var currentPlayerOnTurn: Player?

  init(lastGame: Game) {
    if (lastGame.players?.count != 0) {
      self.game = lastGame
      self.currentPlayerOnTurn = getCurrentPlayerOnTurn()
    }
  }

  init(_ players: [Player] = []) {
    guard !players.isEmpty else { return }
    self.game = Game(players: players, context: context)
    self.currentPlayerOnTurn = getCurrentPlayerOnTurn()
  }

  // 2) calculate the current points the player gets for laying the card
  @Published var playerScore: Int = 0
  @Published var scoreSliderValue: Float = 0
  @Published var timesDrawn: Int = 0
  @Published var playedCard: Bool = true
  
  var calculatedScore: Int64 {
        var calculatedScore = self.scoreSliderValue

    if timesDrawn != 3 {
      calculatedScore = Float(scoreSliderValue) - Float(timesDrawn * 5)
    }

    if timesDrawn == 3 && playedCard {
      calculatedScore = scoreSliderValue - 15
    }

    if timesDrawn == 3 && !playedCard {
      calculatedScore = -25
    }

    return Int64(calculatedScore)
  }

  func resetTurnState() {
    scoreSliderValue = 0
    timesDrawn = 0
    playedCard = true
  }

  func nextPlayer() {
    guard let game = game else { return }
    // update the current player with the score from the currentTurnScore
    updateScore(of: currentPlayerOnTurn, with: calculatedScore)
    
    // append the actual turn to the turns-array to keep track of the turns, but also in the childViewContext, so that if the game is set back all models are untouched
    let newTurn = Turn(game)
    game.addToTurns(newTurn)

    currentPlayerOnTurn = getCurrentPlayerOnTurn()

    saveGameState()
    resetTurnState()
  }

  func updateScore(of player: Player?, with score: Int64) {
    if let player = player {
      player.currentScore += score
    }
  }

  func getCurrentPlayerOnTurn() -> Player? {
    guard let game = self.game else { return nil }

    let playersCount = game.playersArray.count
    let turnsCount = game.turnsArray.count

    if turnsCount != 0 {
      return game.playersArray[turnsCount % playersCount]

    } else {
      if let firstPlayer = game.playersArray.first {
        return firstPlayer
      }
    }
    return nil
  }
  
  // MARK: - GameState Ending
  
  // Alert for ending the game
  @Published var showEndGameAlert: Bool = false
  let endGameAlertTitle: String = "Are you sure?"
  var endGameAlertMessage: String = "The last card is played out by PLAYER ON TURN."
  
  @Published var showExitGameAlert: Bool = false
  let exitGameAlertTitle: String = "Are you sure?"
  let exitGameAlertMessage: String = "Are you sure you want to exit the game? The state of the game is not saved!"
  
  var lastPlayer: Player?
  @Published var playersWithoutLastPlayer: [Player] = []
  @Published var playerToAskForPointsIndex: Int = 0
  @Published var playerToAskForPoints: Player?
  @Published var scoreOfPlayersWithoutLastPlayer: Int64 = 0
  
  func endingGame() {
    guard let game = game else { return }

    lastPlayer = currentPlayerOnTurn
    endGameAlertMessage = "The last card was played out by \(lastPlayer?.name ?? "UNKNOWN")."
    if game.players?.count == 1 {
      endGame()
    }
    
    // Get playerOnTurn of the last turn.
    playersWithoutLastPlayer = game.playersArray.filter({ player in
      player != currentPlayerOnTurn
    })
    
    if let player = playersWithoutLastPlayer.first {
      playerToAskForPoints = player
      gameState = .isEnding
    }
  }
  
  func addPoints(with points: Int64) {
    scoreOfPlayersWithoutLastPlayer += points
    
    playerToAskForPointsIndex += 1
    if playerToAskForPointsIndex < playersWithoutLastPlayer.count {
      playerToAskForPoints = playersWithoutLastPlayer[playerToAskForPointsIndex]
    } else {
      endGame()
    }
  }
  
  // MARK: - GameState Ended
  
  func endGame() {
    guard let game = game else { return }
    // Currently: For every player, save the current score to the highscore, if it's higher.
    // Want to: End the game, get all points correctly and only save the players highscore, if it's a new record.
    if let lastPlayer = lastPlayer {
      // 25 EXTRA POINTS FOR PLAYING OUT THE LAST STONE
      lastPlayer.currentScore += 25
      
      // ADD POINTS FROM ALL OTHER PLAYERS
      lastPlayer.currentScore += scoreOfPlayersWithoutLastPlayer
      
      // GET WINNER WITH HIGHEST SCORE
      let winner = game.playersArray.sorted(by: { $0.currentScore > $1.currentScore }).first!
      winner.increaseGamesWon()
      game.winnerID = winner.id
      
      for player in game.playersArray {
        if player.currentScore > player.highscore {
          player.highscore = player.currentScore
        }
        _ = GameScoreDict.init(gameKey: game.id, player: player)
        store.saveContext(context: context)
      }
      
      game.hasEnded = true
      gameState = .ended
      store.persist(game)
    }
  }
  
  func saveGameState() {
    if let game = game {
      store.persist(game)
    }
  }


}
