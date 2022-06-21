//
//  SessionOnboardingViewModel.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 26.01.22.
//

import Foundation
import SwiftUI

class SessionOnboardingViewModel: ObservableObject {
  @Published var chosenPlayers: [Player] = []
  @Published var session = Session.getLastNotFinishedSession()

  @Published var sessionIsShown: Bool = false

  func toggleIsChosenState(_ player: Player) {
    player.toggleIsChosenStatus()
    if player.isChosen {
      chosenPlayers.append(player)
      player.position = Int16(getPosition(of: player)!)
    } else if let index = chosenPlayers.firstIndex(where: { $0.id == player.id }) {
      chosenPlayers.remove(at: index)
      player.position = 0
    }
  }

  func getPosition(of player: Player) -> Int? {
    if let index = chosenPlayers.firstIndex(where: { $0.id == player.id }) {
      return index + 1
    }
    return nil
  }

  func resetState(of fetchedPlayers: FetchedResults<Player>) {
    for player in fetchedPlayers {
      player.isChosen = false
    }
    chosenPlayers.removeAll()
  }

  func isPlayerChosen(_ player: Player) -> Bool {
    return chosenPlayers.contains(player)
  }

  func startSession() {
    if chosenPlayers.count > 1 {
      session = Session(players: chosenPlayers)
      sessionIsShown = true
    } else if session != nil {
      sessionIsShown = true
    }

    for player in chosenPlayers {
      player.isChosen = false
    }
    chosenPlayers.removeAll()
  }
}
