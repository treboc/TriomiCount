// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Add new player
  internal static let addNewPlayer = L10n.tr("Localizable", "addNewPlayer")
  ///  and 
  internal static let and = L10n.tr("Localizable", "and")
  /// Back
  internal static let back = L10n.tr("Localizable", "back")
  /// Back to Main Menu
  internal static let backToMainMenu = L10n.tr("Localizable", "backToMainMenu")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// , and 
  internal static let joinStringAnd = L10n.tr("Localizable", "joinStringAnd")
  /// Next
  internal static let next = L10n.tr("Localizable", "next")
  /// No
  internal static let no = L10n.tr("Localizable", "no")
  /// Player
  internal static let player = L10n.tr("Localizable", "player")
  /// Players
  internal static let players = L10n.tr("Localizable", "players")
  /// Reset
  internal static let reset = L10n.tr("Localizable", "reset")
  /// Score
  internal static let score = L10n.tr("Localizable", "score")
  /// Session Overview
  internal static let sessionOverview = L10n.tr("Localizable", "sessionOverview")
  /// Sessions
  internal static let sessions = L10n.tr("Localizable", "sessions")
  /// Submit
  internal static let submit = L10n.tr("Localizable", "submit")
  /// Yes
  internal static let yes = L10n.tr("Localizable", "yes")

  internal enum AddNewPlayerView {
    internal enum AlertNameToLong {
      /// I'm sorry, your name is too long!
      internal static let message = L10n.tr("Localizable", "addNewPlayerView.alertNameToLong.message")
    }
    internal enum AlertTextFieldEmpty {
      /// Textfield is empty!
      internal static let message = L10n.tr("Localizable", "addNewPlayerView.alertTextFieldEmpty.message")
    }
    internal enum CreateButton {
      /// Create
      internal static let labelText = L10n.tr("Localizable", "addNewPlayerView.createButton.labelText")
    }
    internal enum NameLabel {
      /// Tell me your name, please!
      internal static let labelText = L10n.tr("Localizable", "addNewPlayerView.nameLabel.labelText")
      /// Name's coming..
      internal static let textfieldText = L10n.tr("Localizable", "addNewPlayerView.nameLabel.textfieldText")
    }
  }

  internal enum EndSessionConfirmationDialogue {
    /// No one can place a tile.
    internal static let messageTie = L10n.tr("Localizable", "endSessionConfirmationDialogue.messageTie")
    /// %@ played out the last tile.
    internal static func messageWinner(_ p1: Any) -> String {
      return L10n.tr("Localizable", "endSessionConfirmationDialogue.messageWinner %@", String(describing: p1))
    }
    /// The session will end
    internal static let title = L10n.tr("Localizable", "endSessionConfirmationDialogue.title")
  }

  internal enum ExitSessionAlert {
    /// Yes, I'm sure.
    internal static let buttonTitle = L10n.tr("Localizable", "exitSessionAlert.buttonTitle")
    /// You're about to leave the session. It's possible that it is not saved..
    internal static let message = L10n.tr("Localizable", "exitSessionAlert.message")
    /// Are you sure?
    internal static let title = L10n.tr("Localizable", "exitSessionAlert.title")
  }

  internal enum HomeView {
    /// New Session
    internal static let newSession = L10n.tr("Localizable", "homeView.newSession")
    /// Players
    internal static let players = L10n.tr("Localizable", "homeView.players")
    /// Resume Last Session
    internal static let resumeLastSession = L10n.tr("Localizable", "homeView.resumeLastSession")
    /// Sessions
    internal static let sessions = L10n.tr("Localizable", "homeView.sessions")
    /// Start New Session
    internal static let startNewSession = L10n.tr("Localizable", "homeView.startNewSession")
  }

  internal enum PlayerDetailView {
    /// Created On
    internal static let createdOn = L10n.tr("Localizable", "playerDetailView.createdOn")
    /// Highscore
    internal static let highscore = L10n.tr("Localizable", "playerDetailView.highscore")
    /// Last Score
    internal static let lastScore = L10n.tr("Localizable", "playerDetailView.lastScore")
    /// Name
    internal static let name = L10n.tr("Localizable", "playerDetailView.name")
    /// Number Of Sessions Played
    internal static let numberOfSessionsPlayed = L10n.tr("Localizable", "playerDetailView.numberOfSessionsPlayed")
    /// Number Of Sessions Won
    internal static let numberOfSessionsWon = L10n.tr("Localizable", "playerDetailView.numberOfSessionsWon")
    internal enum BackButton {
      /// Back
      internal static let title = L10n.tr("Localizable", "playerDetailView.backButton.title")
    }
    internal enum DeleteButton {
      /// Delete Player
      internal static let title = L10n.tr("Localizable", "playerDetailView.deleteButton.title")
    }
    internal enum DeletePlayer {
      /// Are you sure that you want to delete %@? The data can't be restored.
      internal static func alertMessage(_ p1: Any) -> String {
        return L10n.tr("Localizable", "playerDetailView.deletePlayer.alertMessage %@", String(describing: p1))
      }
      /// Warning!
      internal static let alertTitle = L10n.tr("Localizable", "playerDetailView.deletePlayer.alertTitle")
      /// Yes, I'm sure.
      internal static let confirmationButtonTitle = L10n.tr("Localizable", "playerDetailView.deletePlayer.confirmationButtonTitle")
    }
  }

  internal enum PointsSubmitView {
    /// How much points do you have left,
    /// %@?
    internal static func labelText(_ p1: Any) -> String {
      return L10n.tr("Localizable", "pointsSubmitView.labelText %@", String(describing: p1))
    }
    /// Please enter a valid number!
    internal static let overlayAlertMessage = L10n.tr("Localizable", "pointsSubmitView.overlayAlertMessage")
  }

  internal enum Rules {
    /// Rules
    internal static let title = L10n.tr("Localizable", "rules.title")
    internal enum BonusPoints {
      /// It is possible to get some bonus points for special moves:
      /// 
      /// 1. Bridge (one matching Edge and a matching corner) - 40 points.
      /// 2. Completing a hexagon - 50 points.
      /// 3. Two hexagons at the same time - 60 points.
      /// 4. Three hexagons at the same time - 70 points.
      internal static let body = L10n.tr("Localizable", "rules.bonusPoints.body")
      /// Bonus Points
      internal static let header = L10n.tr("Localizable", "rules.bonusPoints.header")
    }
    internal enum EndOfGame {
      /// The player that placed his last tile out of his rack will get 25 bonus points and the combined points of all tiles, that are now still on the other players racks.
      internal static let body = L10n.tr("Localizable", "rules.endOfGame.body")
      /// End of the Game
      internal static let header = L10n.tr("Localizable", "rules.endOfGame.header")
    }
    internal enum LetsGo {
      /// Now each player places a stone with two numbers on each corner, matching the respective corners of a tile that already lies on the table.
      /// 
      /// It is important to ensure that all three corners fit, if you place a tile in between other tiles.
      /// 
      /// If the player on turn can’t or does not want to place a tile, he has to buy one from the well.
      /// 
      /// This will lead to 5 penalty points for each bought tile. It is possible to buy three tiles per round. If you can’t place a tile after buying 3, you get another 10 penalty points (25 total for this round), and the next player is on turn.
      /// 
      /// If you can place a tile after buying, the value of this tile is added to the penalty points (e.g. -10 + 8 → -2 points for this turn.)
      internal static let body = L10n.tr("Localizable", "rules.letsGo.body")
      /// Let's go
      internal static let header = L10n.tr("Localizable", "rules.letsGo.header")
    }
    internal enum Setup {
      /// Mix the tiles face down on the table. One player tracks the score with the help of this app.
      /// Number of tiles:
      /// - 2 players, 9 tiles per player
      /// - 3 to 4 players, 7 tiles
      /// - 5 to 6 players, 6 tiles
      /// Place them on your rack, with the numbered side up, so you can see them.
      /// For getting the first player, there are different ways.
      /// 
      /// First variant:
      /// All players are picking up a tile from the “well” and the player with the highest valued stone begins. This player places a random tile from the well as his first play.
      /// 
      /// Second variant:
      /// The player with the highest valued stone, with three of the same numbers (e.g. 5 - 5 -5, then 4 - 4 - 4, and so on) on his rack, begins by playing this stone out as his first play.
      internal static let body = L10n.tr("Localizable", "rules.setup.body")
      /// Setup
      internal static let header = L10n.tr("Localizable", "rules.setup.header")
    }
  }

  internal enum SessionDetailView {
    /// Played with
    internal static let playedWith = L10n.tr("Localizable", "sessionDetailView.playedWith")
    /// Points
    internal static let points = L10n.tr("Localizable", "sessionDetailView.points")
    /// Winner
    internal static let won = L10n.tr("Localizable", "sessionDetailView.won")
  }

  internal enum SessionListRowView {
    /// Played with:
    internal static let playedBy = L10n.tr("Localizable", "sessionListRowView.playedBy")
    /// Session
    internal static let session = L10n.tr("Localizable", "sessionListRowView.session")
  }

  internal enum SessionListView {
    /// Sessions
    internal static let sessions = L10n.tr("Localizable", "sessionListView.sessions")
    internal enum Button {
      /// Back to Main Menu
      internal static let backToMainMenu = L10n.tr("Localizable", "sessionListView.button.backToMainMenu")
    }
  }

  internal enum SessionOnboardingView {
    /// Add New Player
    internal static let addNewPlayer = L10n.tr("Localizable", "sessionOnboardingView.addNewPlayer")
    /// Back to Main Menu
    internal static let backToMainMenu = L10n.tr("Localizable", "sessionOnboardingView.backToMainMenu")
    /// Please chose the players who are participating in the session.
    internal static let participationHeaderText = L10n.tr("Localizable", "sessionOnboardingView.participationHeaderText")
    /// Start Session
    internal static let startSession = L10n.tr("Localizable", "sessionOnboardingView.startSession")
  }

  internal enum SessionResultsView {
    /// Name
    internal static let name = L10n.tr("Localizable", "sessionResultsView.name")
    /// Points
    internal static let points = L10n.tr("Localizable", "sessionResultsView.points")
    /// Session Results
    internal static let sessionResults = L10n.tr("Localizable", "sessionResultsView.sessionResults")
    internal enum MainMenuButton {
      /// Main menu
      internal static let labelText = L10n.tr("Localizable", "sessionResultsView.mainMenuButton.labelText")
    }
  }

  internal enum SessionView {
    internal enum BonusEventPicker {
      /// Bridge
      internal static let bridge = L10n.tr("Localizable", "sessionView.bonusEventPicker.bridge")
      /// Hexagon
      internal static let hexagon = L10n.tr("Localizable", "sessionView.bonusEventPicker.hexagon")
      /// Do you get some bonus points?
      internal static let labelText = L10n.tr("Localizable", "sessionView.bonusEventPicker.labelText")
      /// None
      internal static let `none` = L10n.tr("Localizable", "sessionView.bonusEventPicker.none")
      /// Three Hexagons
      internal static let threeHexagons = L10n.tr("Localizable", "sessionView.bonusEventPicker.threeHexagons")
      /// Two Hexagons
      internal static let twoHexagons = L10n.tr("Localizable", "sessionView.bonusEventPicker.twoHexagons")
    }
    internal enum DrawnToggle {
      /// Did you have to draw a card?
      internal static let labelText = L10n.tr("Localizable", "sessionView.drawnToggle.labelText")
    }
    internal enum EndSessionButton {
      /// End Session
      internal static let labelText = L10n.tr("Localizable", "sessionView.endSessionButton.labelText")
    }
    internal enum ExitSessionButton {
      /// Exit Session
      internal static let labelText = L10n.tr("Localizable", "sessionView.exitSessionButton.labelText")
    }
    internal enum HeaderLabel {
      /// This turn
      internal static let thisTurnScore = L10n.tr("Localizable", "sessionView.headerLabel.thisTurnScore")
      /// Total score
      internal static let totalScore = L10n.tr("Localizable", "sessionView.headerLabel.totalScore")
    }
    internal enum NextPlayerButton {
      /// Next Player
      internal static let labelText = L10n.tr("Localizable", "sessionView.nextPlayerButton.labelText")
    }
    internal enum PlayedCardPicker {
      /// Were you able to play the card?
      internal static let labelText = L10n.tr("Localizable", "sessionView.playedCardPicker.labelText")
      /// No
      internal static let no = L10n.tr("Localizable", "sessionView.playedCardPicker.no")
      /// Yes
      internal static let yes = L10n.tr("Localizable", "sessionView.playedCardPicker.yes")
    }
    internal enum ScoreSlider {
      /// How many points is your card worth?
      internal static let labelText = L10n.tr("Localizable", "sessionView.scoreSlider.labelText")
    }
    internal enum TimesDrawnPicker {
      /// How often did you have to draw?
      internal static let labelText = L10n.tr("Localizable", "sessionView.timesDrawnPicker.labelText")
    }
    internal enum UndoButton {
      /// Undo last turn
      internal static let labelText = L10n.tr("Localizable", "sessionView.undoButton.labelText")
    }
  }

  internal enum SettingsView {
    /// Settings
    internal static let settings = L10n.tr("Localizable", "settingsView.settings")
    internal enum ColorScheme {
      /// Dark
      internal static let dark = L10n.tr("Localizable", "settingsView.colorScheme.dark")
      /// Light
      internal static let light = L10n.tr("Localizable", "settingsView.colorScheme.light")
      /// Automatic
      internal static let system = L10n.tr("Localizable", "settingsView.colorScheme.system")
      /// Appearance
      internal static let title = L10n.tr("Localizable", "settingsView.colorScheme.title")
    }
    internal enum IdleDimmingDisabled {
      /// IMPORTANT: This will reduce your battery life.
      internal static let importantMessage = L10n.tr("Localizable", "settingsView.idleDimmingDisabled.importantMessage")
      /// Options
      internal static let options = L10n.tr("Localizable", "settingsView.idleDimmingDisabled.options")
      /// Disable screen dimming in sessions
      internal static let pickerLabelText = L10n.tr("Localizable", "settingsView.idleDimmingDisabled.pickerLabelText")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
