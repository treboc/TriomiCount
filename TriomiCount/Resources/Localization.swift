//
//  Localization.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 20.04.22.
//

import Foundation
import SwiftUI

struct Localization {
  struct HomeView {
    static let newGame: LocalizedStringKey = "homeView.newGame"
    static let resume: LocalizedStringKey = "homeView.resume"
    static let players: LocalizedStringKey = "homeView.players"
    static let games: LocalizedStringKey = "homeView.games"
  }

  struct GameOnboardingView {
    static let participationHeader: LocalizedStringKey = "gameOnboardingView.participationHeaderText"
    static let addNewPlayer: LocalizedStringKey = "gameOnboardingView.addNewPlayer"
    static let startGame: LocalizedStringKey = "gameOnboardingView.startGame"
    static let backToMainMenu: LocalizedStringKey = "gameOnboardingView.backToMainMenu"
  }

  struct GameView {
    static let headerLabelTotalScore: LocalizedStringKey = "gameView.headerLabel.totalScore"
    static let headerLabelThisTurnScore: LocalizedStringKey = "gameView.headerLabel.thisTurnScore"
    static let scoreSliderLabelText: LocalizedStringKey = "gameView.scoreSlider.labelText"
    static let drawnToggleLabelText: LocalizedStringKey = "gameView.drawnToggle.labelText"
    static let timesDrawnPickerLabelText: LocalizedStringKey = "gameView.timesDrawnPicker.labelText"
    static let playedCardPickerLabelText: LocalizedStringKey = "gameView.playedCardPicker.labelText"
    static let playedCardPickerYes: LocalizedStringKey = "gameView.playedCardPicker.yes"
    static let playedCardPickerNo: LocalizedStringKey = "gameView.playedCardPicker.no"
    static let bonusEventPickerLabelText: LocalizedStringKey = "gameView.bonusEventPicker.labelText"
    static let bonusEventPickerNone: LocalizedStringKey = "gameView.bonusEventPicker.none"
    static let bonusEventPickerBridge: LocalizedStringKey = "gameView.bonusEventPicker.bridge"
    static let bonusEventPickerHexagon: LocalizedStringKey = "gameView.bonusEventPicker.hexagon"
    static let bonusEventPickerTwoHexagons: LocalizedStringKey = "gameView.bonusEventPicker.twoHexagons"
    static let bonusEventPickerThreeHexagons: LocalizedStringKey = "gameView.bonusEventPicker.threeHexagons"
    static let nextPlayerButtonLabelText: LocalizedStringKey = "gameView.nextPlayerButton.labelText"
    static let exitGameButtonLabelText: LocalizedStringKey = "gameView.exitGameButton.labelText"
    static let endGameButtonLabelText: LocalizedStringKey = "gameView.endGameButton.labelText"
  }

  struct GameResultsView {
    static let gameResults: LocalizedStringKey = "gameResultsView.gameResults"
    static let name: LocalizedStringKey = "gameResultsView.name"
    static let points: LocalizedStringKey = "gameResultsView.points"
    static let mainMenuButtonLabelText: LocalizedStringKey = "gameResultsView.mainMenuButton.labelText"
  }

  struct OneWordConstants {
    static let yes: LocalizedStringKey = "Yes"
    static let no: LocalizedStringKey = "No"
    static let reset: LocalizedStringKey = "Reset"
    static let cancel: LocalizedStringKey = "Cancel"
    static let back: LocalizedStringKey = "Back"
  }
}
