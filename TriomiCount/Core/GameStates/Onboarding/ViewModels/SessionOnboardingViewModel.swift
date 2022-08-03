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
  @Published var session = SessionService.getLastNotFinishedSession()
  @Published var sessionIsShown: Bool = false
  @Published var newPlayerSheetIsShown: Bool = false

  var startSessionButtonIsDisabled: Bool {
    if session != nil && chosenPlayers.count < 2 {
      return false
    } else if chosenPlayers.count > 1 {
      return false
    } else {
      return true
    }
  }

  func choose(_ player: Player) {
    PlayerService.toggleChosenState(player)
    if player.isChosen {
      chosenPlayers.append(player)
      player.position = PlayerService.getPosition(of: player, in: chosenPlayers) ?? 0
    } else if let index = chosenPlayers.firstIndex(where: { $0.id == player.id }) {
      chosenPlayers.remove(at: index)
      player.position = 0
    }
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
      session = SessionService.addSession(with: chosenPlayers)
      sessionIsShown = true
    } else if session != nil {
      sessionIsShown = true
    }

    for player in chosenPlayers {
      player.isChosen = false
    }
    chosenPlayers.removeAll()
  }

  func checkForUnfinishedSession() {
    session = SessionService.getLastNotFinishedSession()
  }
}
