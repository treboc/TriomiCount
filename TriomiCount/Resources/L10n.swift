// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Back
  internal static let back = L10n.tr("Localizable", "back", fallback: "Back")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel", fallback: "Cancel")
  /// New Session
  internal static let newSession = L10n.tr("Localizable", "newSession", fallback: "New Session")
  /// Next
  internal static let next = L10n.tr("Localizable", "next", fallback: "Next")
  /// No
  internal static let no = L10n.tr("Localizable", "no", fallback: "No")
  /// Player
  internal static let player = L10n.tr("Localizable", "player", fallback: "Player")
  /// Players
  internal static let players = L10n.tr("Localizable", "players", fallback: "Players")
  /// Reset
  internal static let reset = L10n.tr("Localizable", "reset", fallback: "Reset")
  /// Score
  internal static let score = L10n.tr("Localizable", "score", fallback: "Score")
  /// Session Overview
  internal static let sessionOverview = L10n.tr("Localizable", "sessionOverview", fallback: "Session Overview")
  /// Sessions
  internal static let sessions = L10n.tr("Localizable", "sessions", fallback: "Sessions")
  /// Settings
  internal static let settings = L10n.tr("Localizable", "settings", fallback: "Settings")
  /// Submit
  internal static let submit = L10n.tr("Localizable", "submit", fallback: "Submit")
  /// Yes
  internal static let yes = L10n.tr("Localizable", "yes", fallback: "Yes")
  internal enum AddNewPlayerView {
    internal enum AlertNameToLong {
      /// I'm sorry, your name is too long!
      internal static let message = L10n.tr("Localizable", "addNewPlayerView.alertNameToLong.message", fallback: "I'm sorry, your name is too long!")
    }
    internal enum AlertTextFieldEmpty {
      /// Textfield is empty!
      internal static let message = L10n.tr("Localizable", "addNewPlayerView.alertTextFieldEmpty.message", fallback: "Textfield is empty!")
    }
    internal enum CreateButton {
      /// Create
      internal static let labelText = L10n.tr("Localizable", "addNewPlayerView.createButton.labelText", fallback: "Create")
    }
    internal enum NameLabel {
      /// Tell me your name, please!
      internal static let labelText = L10n.tr("Localizable", "addNewPlayerView.nameLabel.labelText", fallback: "Tell me your name, please!")
      /// Name's coming..
      internal static let textfieldText = L10n.tr("Localizable", "addNewPlayerView.nameLabel.textfieldText", fallback: "Name's coming..")
    }
  }
  internal enum Button {
    /// Add new player
    internal static let addNewPlayer = L10n.tr("Localizable", "button.addNewPlayer", fallback: "Add new player")
    /// Back to Main Menu
    internal static let backToMainMenu = L10n.tr("Localizable", "button.backToMainMenu", fallback: "Back to Main Menu")
    /// Resume Last Session
    internal static let resumeLastSession = L10n.tr("Localizable", "button.resumeLastSession", fallback: "Resume Last Session")
    /// Start New Session
    internal static let startNewSession = L10n.tr("Localizable", "button.startNewSession", fallback: "Start New Session")
  }
  internal enum EndSessionConfirmationDialogue {
    /// No one can place a tile.
    internal static let messageTie = L10n.tr("Localizable", "endSessionConfirmationDialogue.messageTie", fallback: "No one can place a tile.")
    /// %@ played out the last tile.
    internal static func messageWinner(_ p1: Any) -> String {
      return L10n.tr("Localizable", "endSessionConfirmationDialogue.messageWinner %@", String(describing: p1), fallback: "%@ played out the last tile.")
    }
    /// The session will end
    internal static let title = L10n.tr("Localizable", "endSessionConfirmationDialogue.title", fallback: "The session will end")
  }
  internal enum ExitSessionAlert {
    /// Yes, I'm sure.
    internal static let buttonTitle = L10n.tr("Localizable", "exitSessionAlert.buttonTitle", fallback: "Yes, I'm sure.")
    /// You're about to leave the session. It's possible that it is not saved..
    internal static let message = L10n.tr("Localizable", "exitSessionAlert.message", fallback: "You're about to leave the session. It's possible that it is not saved..")
    /// Are you sure?
    internal static let title = L10n.tr("Localizable", "exitSessionAlert.title", fallback: "Are you sure?")
  }
  internal enum LegalNoticeView {
    /// Legal Notice
    internal static let title = L10n.tr("Localizable", "legalNoticeView.title", fallback: "Legal Notice")
  }
  internal enum PlayerDetailView {
    /// Created On
    internal static let createdOn = L10n.tr("Localizable", "playerDetailView.createdOn", fallback: "Created On")
    /// Highscore
    internal static let highscore = L10n.tr("Localizable", "playerDetailView.highscore", fallback: "Highscore")
    /// Last Score
    internal static let lastScore = L10n.tr("Localizable", "playerDetailView.lastScore", fallback: "Last Score")
    /// Name
    internal static let name = L10n.tr("Localizable", "playerDetailView.name", fallback: "Name")
    /// Number Of Sessions Played
    internal static let numberOfSessionsPlayed = L10n.tr("Localizable", "playerDetailView.numberOfSessionsPlayed", fallback: "Number Of Sessions Played")
    /// Number Of Sessions Won
    internal static let numberOfSessionsWon = L10n.tr("Localizable", "playerDetailView.numberOfSessionsWon", fallback: "Number Of Sessions Won")
    internal enum BackButton {
      /// Back
      internal static let title = L10n.tr("Localizable", "playerDetailView.backButton.title", fallback: "Back")
    }
    internal enum DeleteButton {
      /// Delete Player
      internal static let title = L10n.tr("Localizable", "playerDetailView.deleteButton.title", fallback: "Delete Player")
    }
    internal enum DeletePlayer {
      /// Are you sure that you want to delete %@? The data can't be restored.
      internal static func alertMessage(_ p1: Any) -> String {
        return L10n.tr("Localizable", "playerDetailView.deletePlayer.alertMessage %@", String(describing: p1), fallback: "Are you sure that you want to delete %@? The data can't be restored.")
      }
      /// Warning!
      internal static let alertTitle = L10n.tr("Localizable", "playerDetailView.deletePlayer.alertTitle", fallback: "Warning!")
      /// Yes, I'm sure.
      internal static let confirmationButtonTitle = L10n.tr("Localizable", "playerDetailView.deletePlayer.confirmationButtonTitle", fallback: "Yes, I'm sure.")
    }
  }
  internal enum PlayerListView {
    /// No player created yet, start creating one by tapping the + in the top right corner.
    internal static let noPlayersInfo = L10n.tr("Localizable", "playerListView.noPlayersInfo", fallback: "No player created yet, start creating one by tapping the + in the top right corner.")
  }
  internal enum PointsSubmitView {
    /// How much points do you have left,
    /// %@?
    internal static func labelText(_ p1: Any) -> String {
      return L10n.tr("Localizable", "pointsSubmitView.labelText %@", String(describing: p1), fallback: "How much points do you have left,\n%@?")
    }
    /// Please enter a valid number!
    internal static let overlayAlertMessage = L10n.tr("Localizable", "pointsSubmitView.overlayAlertMessage", fallback: "Please enter a valid number!")
  }
  internal enum Rules {
    /// Rules
    internal static let title = L10n.tr("Localizable", "rules.title", fallback: "Rules")
    internal enum BonusPoints {
      /// It is possible to get some bonus points for special moves:
      /// 
      /// 1. Bridge (one matching Edge and a matching corner) - 40 points.
      /// 2. Completing a hexagon - 50 points.
      /// 3. Two hexagons at the same time - 60 points.
      /// 4. Three hexagons at the same time - 70 points.
      internal static let body = L10n.tr("Localizable", "rules.bonusPoints.body", fallback: "It is possible to get some bonus points for special moves:\n\n1. Bridge (one matching Edge and a matching corner) - 40 points.\n2. Completing a hexagon - 50 points.\n3. Two hexagons at the same time - 60 points.\n4. Three hexagons at the same time - 70 points.")
      /// Bonus Points
      internal static let header = L10n.tr("Localizable", "rules.bonusPoints.header", fallback: "Bonus Points")
    }
    internal enum EndOfGame {
      /// The player that placed his last tile out of his rack will get 25 bonus points and the combined points of all tiles, that are now still on the other players racks.
      internal static let body = L10n.tr("Localizable", "rules.endOfGame.body", fallback: "The player that placed his last tile out of his rack will get 25 bonus points and the combined points of all tiles, that are now still on the other players racks.")
      /// End of the Game
      internal static let header = L10n.tr("Localizable", "rules.endOfGame.header", fallback: "End of the Game")
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
      internal static let body = L10n.tr("Localizable", "rules.letsGo.body", fallback: "Now each player places a stone with two numbers on each corner, matching the respective corners of a tile that already lies on the table.\n\nIt is important to ensure that all three corners fit, if you place a tile in between other tiles.\n\nIf the player on turn can’t or does not want to place a tile, he has to buy one from the well.\n\nThis will lead to 5 penalty points for each bought tile. It is possible to buy three tiles per round. If you can’t place a tile after buying 3, you get another 10 penalty points (25 total for this round), and the next player is on turn.\n\nIf you can place a tile after buying, the value of this tile is added to the penalty points (e.g. -10 + 8 → -2 points for this turn.)")
      /// Let's go
      internal static let header = L10n.tr("Localizable", "rules.letsGo.header", fallback: "Let's go")
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
      internal static let body = L10n.tr("Localizable", "rules.setup.body", fallback: "Mix the tiles face down on the table. One player tracks the score with the help of this app.\nNumber of tiles:\n- 2 players, 9 tiles per player\n- 3 to 4 players, 7 tiles\n- 5 to 6 players, 6 tiles\nPlace them on your rack, with the numbered side up, so you can see them.\nFor getting the first player, there are different ways.\n\nFirst variant:\nAll players are picking up a tile from the “well” and the player with the highest valued stone begins. This player places a random tile from the well as his first play.\n\nSecond variant:\nThe player with the highest valued stone, with three of the same numbers (e.g. 5 - 5 -5, then 4 - 4 - 4, and so on) on his rack, begins by playing this stone out as his first play.")
      /// Setup
      internal static let header = L10n.tr("Localizable", "rules.setup.header", fallback: "Setup")
    }
  }
  internal enum SessionDetailView {
    /// Played with
    internal static let playedWith = L10n.tr("Localizable", "sessionDetailView.playedWith", fallback: "Played with")
    /// Points
    internal static let points = L10n.tr("Localizable", "sessionDetailView.points", fallback: "Points")
    /// Winner
    internal static let won = L10n.tr("Localizable", "sessionDetailView.won", fallback: "Winner")
  }
  internal enum SessionListRowView {
    /// Played with:
    internal static let playedBy = L10n.tr("Localizable", "sessionListRowView.playedBy", fallback: "Played with:")
    /// Session
    internal static let session = L10n.tr("Localizable", "sessionListRowView.session", fallback: "Session")
  }
  internal enum SessionListView {
    /// No games played yet. Come back later after you played a round or two, to see some details.
    internal static let noSessionInfo = L10n.tr("Localizable", "sessionListView.noSessionInfo", fallback: "No games played yet. Come back later after you played a round or two, to see some details.")
    /// Sessions
    internal static let sessions = L10n.tr("Localizable", "sessionListView.sessions", fallback: "Sessions")
    internal enum Button {
      /// Back to Main Menu
      internal static let backToMainMenu = L10n.tr("Localizable", "sessionListView.button.backToMainMenu", fallback: "Back to Main Menu")
    }
  }
  internal enum SessionOnboardingView {
    /// Localizable.strings
    ///  TriomiCount
    /// 
    ///  Created by Marvin Lee Kobert on 04.03.22.
    internal static let addTwoPlayers = L10n.tr("Localizable", "sessionOnboardingView.addTwoPlayers", fallback: "Please add atleast two players to start a game.")
  }
  internal enum SessionResultsView {
    /// Name
    internal static let name = L10n.tr("Localizable", "sessionResultsView.name", fallback: "Name")
    /// Points
    internal static let points = L10n.tr("Localizable", "sessionResultsView.points", fallback: "Points")
    /// Session Results
    internal static let sessionResults = L10n.tr("Localizable", "sessionResultsView.sessionResults", fallback: "Session Results")
    internal enum MainMenuButton {
      /// Main menu
      internal static let labelText = L10n.tr("Localizable", "sessionResultsView.mainMenuButton.labelText", fallback: "Main menu")
    }
  }
  internal enum SessionView {
    internal enum BonusEventPicker {
      /// Bridge
      internal static let bridge = L10n.tr("Localizable", "sessionView.bonusEventPicker.bridge", fallback: "Bridge")
      /// Hexagon
      internal static let hexagon = L10n.tr("Localizable", "sessionView.bonusEventPicker.hexagon", fallback: "Hexagon")
      /// Do you get some bonus points?
      internal static let labelText = L10n.tr("Localizable", "sessionView.bonusEventPicker.labelText", fallback: "Do you get some bonus points?")
      /// None
      internal static let `none` = L10n.tr("Localizable", "sessionView.bonusEventPicker.none", fallback: "None")
      /// Three Hexagons
      internal static let threeHexagons = L10n.tr("Localizable", "sessionView.bonusEventPicker.threeHexagons", fallback: "Three Hexagons")
      /// Two Hexagons
      internal static let twoHexagons = L10n.tr("Localizable", "sessionView.bonusEventPicker.twoHexagons", fallback: "Two Hexagons")
    }
    internal enum DrawnToggle {
      /// Did you have to draw a card?
      internal static let labelText = L10n.tr("Localizable", "sessionView.drawnToggle.labelText", fallback: "Did you have to draw a card?")
    }
    internal enum EndSessionButton {
      /// End Session
      internal static let labelText = L10n.tr("Localizable", "sessionView.endSessionButton.labelText", fallback: "End Session")
    }
    internal enum ExitSessionButton {
      /// Exit Session
      internal static let labelText = L10n.tr("Localizable", "sessionView.exitSessionButton.labelText", fallback: "Exit Session")
    }
    internal enum HeaderLabel {
      /// This turn
      internal static let thisTurnScore = L10n.tr("Localizable", "sessionView.headerLabel.thisTurnScore", fallback: "This turn")
      /// Total score
      internal static let totalScore = L10n.tr("Localizable", "sessionView.headerLabel.totalScore", fallback: "Total score")
    }
    internal enum NextPlayerButton {
      /// Next Player
      internal static let labelText = L10n.tr("Localizable", "sessionView.nextPlayerButton.labelText", fallback: "Next Player")
    }
    internal enum PlayedCardPicker {
      /// Were you able to play the card?
      internal static let labelText = L10n.tr("Localizable", "sessionView.playedCardPicker.labelText", fallback: "Were you able to play the card?")
      /// No
      internal static let no = L10n.tr("Localizable", "sessionView.playedCardPicker.no", fallback: "No")
      /// Yes
      internal static let yes = L10n.tr("Localizable", "sessionView.playedCardPicker.yes", fallback: "Yes")
    }
    internal enum ScoreSlider {
      /// How many points is your card worth?
      internal static let labelText = L10n.tr("Localizable", "sessionView.scoreSlider.labelText", fallback: "How many points is your card worth?")
    }
    internal enum TimesDrawnPicker {
      /// How often did you have to draw?
      internal static let labelText = L10n.tr("Localizable", "sessionView.timesDrawnPicker.labelText", fallback: "How often did you have to draw?")
    }
    internal enum UndoButton {
      /// Undo last turn
      internal static let labelText = L10n.tr("Localizable", "sessionView.undoButton.labelText", fallback: "Undo last turn")
    }
  }
  internal enum SettingsView {
    /// Settings
    internal static let title = L10n.tr("Localizable", "settingsView.title", fallback: "Settings")
    internal enum ColorScheme {
      /// Dark
      internal static let dark = L10n.tr("Localizable", "settingsView.colorScheme.dark", fallback: "Dark")
      /// Light
      internal static let light = L10n.tr("Localizable", "settingsView.colorScheme.light", fallback: "Light")
      /// Select Theme
      internal static let pickerTitle = L10n.tr("Localizable", "settingsView.colorScheme.pickerTitle", fallback: "Select Theme")
      /// System
      internal static let system = L10n.tr("Localizable", "settingsView.colorScheme.system", fallback: "System")
      /// Appearance
      internal static let title = L10n.tr("Localizable", "settingsView.colorScheme.title", fallback: "Appearance")
    }
    internal enum IdleDimmingDisabled {
      /// IMPORTANT: This will reduce your battery life.
      internal static let importantMessage = L10n.tr("Localizable", "settingsView.idleDimmingDisabled.importantMessage", fallback: "IMPORTANT: This will reduce your battery life.")
      /// Options
      internal static let options = L10n.tr("Localizable", "settingsView.idleDimmingDisabled.options", fallback: "Options")
      /// Disable screen dimming in sessions
      internal static let pickerLabelText = L10n.tr("Localizable", "settingsView.idleDimmingDisabled.pickerLabelText", fallback: "Disable screen dimming in sessions")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
