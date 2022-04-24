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
  /// Back
  internal static let back = L10n.tr("Localizable", "back")
  /// Back to Main Menu
  internal static let backToMainMenu = L10n.tr("Localizable", "backToMainMenu")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// Games
  internal static let games = L10n.tr("Localizable", "games")
  ///  and 
  internal static let joinStringAnd = L10n.tr("Localizable", "joinStringAnd")
  /// Next
  internal static let next = L10n.tr("Localizable", "next")
  /// No
  internal static let no = L10n.tr("Localizable", "no")
  /// Players
  internal static let players = L10n.tr("Localizable", "players")
  /// Reset
  internal static let reset = L10n.tr("Localizable", "reset")
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

  internal enum EndGameConfirmationDialogue {
    /// No one can place a tile.
    internal static let messageTie = L10n.tr("Localizable", "endGameConfirmationDialogue.messageTie")
    /// Congratulations %@!
    internal static func messageWinner(_ p1: Any) -> String {
      return L10n.tr("Localizable", "endGameConfirmationDialogue.messageWinner %@", String(describing: p1))
    }
    /// The game will end
    internal static let title = L10n.tr("Localizable", "endGameConfirmationDialogue.title")
  }

  internal enum ExitGameAlert {
    /// Yes, I'm sure.
    internal static let buttonTitle = L10n.tr("Localizable", "exitGameAlert.buttonTitle")
    /// You're about to leave the game. It's possible that it is not saved..
    internal static let message = L10n.tr("Localizable", "exitGameAlert.message")
    /// Are you sure?
    internal static let title = L10n.tr("Localizable", "exitGameAlert.title")
  }

  internal enum GameDetailView {
    /// Played with
    internal static let playedWith = L10n.tr("Localizable", "gameDetailView.playedWith")
    /// Points
    internal static let points = L10n.tr("Localizable", "gameDetailView.points")
    /// Winner
    internal static let won = L10n.tr("Localizable", "gameDetailView.won")
  }

  internal enum GameListRowView {
    /// Played with:
    internal static let playedBy = L10n.tr("Localizable", "gameListRowView.playedBy")
    /// Session
    internal static let session = L10n.tr("Localizable", "gameListRowView.session")
  }

  internal enum GameListView {
    /// Sessions
    internal static let sessions = L10n.tr("Localizable", "gameListView.sessions")
    internal enum Button {
      /// Back to Main Menu
      internal static let backToMainMenu = L10n.tr("Localizable", "gameListView.button.backToMainMenu")
    }
  }

  internal enum GameOnboardingView {
    /// Add New Player
    internal static let addNewPlayer = L10n.tr("Localizable", "gameOnboardingView.addNewPlayer")
    /// Back to Main Menu
    internal static let backToMainMenu = L10n.tr("Localizable", "gameOnboardingView.backToMainMenu")
    /// Please chose the players who are participating in the game.
    internal static let participationHeaderText = L10n.tr("Localizable", "gameOnboardingView.participationHeaderText")
    /// Start Game
    internal static let startGame = L10n.tr("Localizable", "gameOnboardingView.startGame")
  }

  internal enum GameResultsView {
    /// Game Results
    internal static let gameResults = L10n.tr("Localizable", "gameResultsView.gameResults")
    /// Name
    internal static let name = L10n.tr("Localizable", "gameResultsView.name")
    /// Points
    internal static let points = L10n.tr("Localizable", "gameResultsView.points")
    internal enum MainMenuButton {
      /// Main menu
      internal static let labelText = L10n.tr("Localizable", "gameResultsView.mainMenuButton.labelText")
    }
  }

  internal enum GameView {
    internal enum BonusEventPicker {
      /// Bridge
      internal static let bridge = L10n.tr("Localizable", "gameView.bonusEventPicker.bridge")
      /// Hexagon
      internal static let hexagon = L10n.tr("Localizable", "gameView.bonusEventPicker.hexagon")
      /// Do you get some bonus points?
      internal static let labelText = L10n.tr("Localizable", "gameView.bonusEventPicker.labelText")
      /// None
      internal static let `none` = L10n.tr("Localizable", "gameView.bonusEventPicker.none")
      /// Three Hexagons
      internal static let threeHexagons = L10n.tr("Localizable", "gameView.bonusEventPicker.threeHexagons")
      /// Two Hexagons
      internal static let twoHexagons = L10n.tr("Localizable", "gameView.bonusEventPicker.twoHexagons")
    }
    internal enum DrawnToggle {
      /// Did you have to draw a card?
      internal static let labelText = L10n.tr("Localizable", "gameView.drawnToggle.labelText")
    }
    internal enum EndGameButton {
      /// End Game
      internal static let labelText = L10n.tr("Localizable", "gameView.endGameButton.labelText")
    }
    internal enum ExitGameButton {
      /// Exit Game
      internal static let labelText = L10n.tr("Localizable", "gameView.exitGameButton.labelText")
    }
    internal enum HeaderLabel {
      /// This turn
      internal static let thisTurnScore = L10n.tr("Localizable", "gameView.headerLabel.thisTurnScore")
      /// Total score
      internal static let totalScore = L10n.tr("Localizable", "gameView.headerLabel.totalScore")
    }
    internal enum NextPlayerButton {
      /// Next Player
      internal static let labelText = L10n.tr("Localizable", "gameView.nextPlayerButton.labelText")
    }
    internal enum PlayedCardPicker {
      /// Were you able to play the card?
      internal static let labelText = L10n.tr("Localizable", "gameView.playedCardPicker.labelText")
      /// No
      internal static let no = L10n.tr("Localizable", "gameView.playedCardPicker.no")
      /// Yes
      internal static let yes = L10n.tr("Localizable", "gameView.playedCardPicker.yes")
    }
    internal enum ScoreSlider {
      /// How many points is your card worth?
      internal static let labelText = L10n.tr("Localizable", "gameView.scoreSlider.labelText")
    }
    internal enum TimesDrawnPicker {
      /// How many times did you have to draw?
      internal static let labelText = L10n.tr("Localizable", "gameView.timesDrawnPicker.labelText")
    }
  }

  internal enum HomeView {
    /// Games
    internal static let games = L10n.tr("Localizable", "homeView.games")
    /// New Game
    internal static let newGame = L10n.tr("Localizable", "homeView.newGame")
    /// Players
    internal static let players = L10n.tr("Localizable", "homeView.players")
    /// Resume
    internal static let resume = L10n.tr("Localizable", "homeView.resume")
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
    /// Number Of Games Played
    internal static let numberOfGamesPlayed = L10n.tr("Localizable", "playerDetailView.numberOfGamesPlayed")
    /// Number Of Games Won
    internal static let numberOfGamesWon = L10n.tr("Localizable", "playerDetailView.numberOfGamesWon")
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
      /// 
      /// Number of tiles:
      /// - 2 players, 9 tiles per player
      /// - 3 to 4 players, 7 tiles
      /// - 5 to 6 players, 6 tiles
      /// 
      /// Place them on your rack, with the numbered side up, so you can see them.
      /// For getting the first player, there are different ways.
      /// 
      /// **First variant:**
      /// All players are picking up a tile from the “well” and the player with the highest valued stone begins. This player places a random tile from the well as his first play.
      /// 
      /// **Second variant:**
      /// The player with the highest valued stone, with three of the same numbers (e.g. 5 - 5 -5, then 4 - 4 - 4, and so on) on his rack, begins by playing this stone out as his first play.
      internal static let body = L10n.tr("Localizable", "rules.setup.body")
      /// Setup
      internal static let header = L10n.tr("Localizable", "rules.setup.header")
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
      /// System
      internal static let system = L10n.tr("Localizable", "settingsView.colorScheme.system")
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
