//
//  GameOnboardingViewModel.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 26.01.22.
//

import Foundation
import SwiftUI

class GameOnboardingViewModel: ObservableObject {
    @Published var chosenPlayers: [Player] = []

    func toggleIsChosenState(_ player: Player) {
        player.toggleIsChosenStatus()
        if player.isChosen {
            chosenPlayers.append(player)
            player.position = Int16(getPosition(ofChosenPlayer: player)!)
        } else if let index = chosenPlayers.firstIndex(where: { $0.id == player.id }) {
            chosenPlayers.remove(at: index)
            player.position = 0
        }
    }

    func getPosition(ofChosenPlayer player: Player) -> Int? {
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
}
